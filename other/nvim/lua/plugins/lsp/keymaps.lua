local general_utils = require("util.general")
local config_utils = require("util")
local M = {}
config_utils.lsp.on_attach(function(client, buffer) end)

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string}
---@alias LazyKeysLsp LazyKeys|{has?:string}

local default_keys = {
    {
        "<leader>cl",
        "<cmd>LspInfo<cr>",
        desc = "Lsp Info",
    },
    {
        "gd",
        function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
        desc = "Goto Definition",
        has = "definition",
    },
    {
        "gr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "References",
    },
    {
        "gD",
        vim.lsp.buf.declaration,
        desc = "Goto Declaration",
    },
    {
        "gI",
        function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
        desc = "Goto Implementation",
    },
    {
        "gy",
        function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
        desc = "Goto T[y]pe Definition",
    },
    {
        "K",
        vim.lsp.buf.hover,
        desc = "Hover",
    },
    {
        "gK",
        vim.lsp.buf.signature_help,
        desc = "Signature Help",
        has = "signatureHelp",
    },
    {
        "<c-k>",
        vim.lsp.buf.signature_help,
        mode = "i",
        desc = "Signature Help",
        has = "signatureHelp",
    },
    {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
        has = "codeAction",
    },
    {
        "<leader>cc",
        vim.lsp.codelens.run,
        desc = "Run Codelens",
        mode = { "n", "v" },
        has = "codeLens",
    },
    {
        "<leader>cC",
        vim.lsp.codelens.refresh,
        desc = "Refresh & Display Codelens",
        mode = { "n" },
        has = "codeLens",
    },
    {
        "<leader>cA",
        function() vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } }) end,
        desc = "Source Action",
        has = "codeAction",
    },
    -- { "]]", function() config_utils.lsp.words.jump(vim.v.count1) end, has = "documentHighlight", desc = "Next Reference" },
    -- { "[[", function() config_utils.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight", desc = "Prev Reference", },
    -- { "<a-n>", function() config_utils.lsp.words.jump(vim.v.count1, true) end, has = "documentHighlight", desc = "Next Reference", },
    -- { "<a-p>", function() config_utils.lsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight", desc = "Prev Reference", },
}

---@return LazyKeysLspSpec[]
function M.get()
    if M._keys then return M._keys end
    M._keys = default_keys
    if require("lazy.core.config").spec.plugins["inc-rename.nvim"] ~= nil then
        M._keys[#M._keys + 1] = {
            "<leader>cr",
            function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
            end,
            expr = true,
            desc = "Rename",
            has = "rename",
        }
    else
        M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    end
    return M._keys
end

---@param method string
function M.has(buffer, method)
    method = method:find("/") and method or "textDocument/" .. method
    local clients = config_utils.lsp.get_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        if client.supports_method(method) then return true end
    end
    return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
    local Keys = require("lazy.core.handler.keys")
    if not Keys.resolve then return {} end
    local spec = M.get()
    local opts = general_utils.get_plugin_opts("nvim-lspconfig")
    local clients = config_utils.lsp.get_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
        vim.list_extend(spec, maps)
    end
    return Keys.resolve(spec)
end

local function load_cursor_highlight(client, buffer)
    local id = {}
    local cursor_highlight = nil
    local enable = function()
        cursor_highlight = true
        local tbl = {
            next_lsp_word = function() config_utils.lsp.words.jump(vim.v.count1) end,
            prev_lsp_word = function() config_utils.lsp.words.jump(-vim.v.count1) end,
        }
        vim.keymap.set("n", "]]", tbl.next_lsp_word, { buffer = buffer, desc = "Next reference" })
        vim.keymap.set("n", "[[", tbl.prev_lsp_word, { buffer = buffer, desc = "Previous reference" })
        id.hl_autocmd = vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
            group = vim.api.nvim_create_augroup("lsp_word_" .. buffer, { clear = true }),
            buffer = buffer,
            callback = function(ev)
                if not config_utils.lsp.words.at() then
                    if ev.event:find("CursorMoved") then
                        vim.lsp.buf.clear_references()
                    else
                        vim.lsp.buf.document_highlight()
                    end
                end
            end,
        })
    end

    local disable = function()
        cursor_highlight = false
        vim.keymap.del("n", "]]", { buffer = buffer, desc = "Next reference" })
        vim.keymap.del("n", "[[", { buffer = buffer, desc = "Previous reference" })
        if id.hl_autocmd then vim.api.nvim_del_autocmd(id.hl_autocmd) end
        vim.lsp.buf.clear_references()
    end
    vim.keymap.set("n", "<leader>tr", function()
        if client.supports_method("textDocument/documentHighlight") then
            if cursor_highlight then
                disable()
            else
                enable()
            end
        end
    end, { desc = "[T]oggle [R]eferences" })
end

function M.on_attach(client, buffer)
    load_cursor_highlight(client, buffer)
    local Keys = require("lazy.core.handler.keys")
    local keymaps = M.resolve(buffer)
    for _, keys in pairs(keymaps) do
        if not keys.has or M.has(buffer, keys.has) then
            ---@class opts: LazyKeysBase
            local opts = Keys.opts(keys)
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
        end
    end
end

return M
