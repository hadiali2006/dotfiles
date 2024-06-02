local general_utils = require("util.general")
local config_utils = require("util")
local lazy_utils = require("lazy.core.util")
return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cF",
            function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
        {
            "<leader>f",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    init = function()
        -- Install the conform formatter on VeryLazy
        general_utils.on_very_lazy(function()
            config_utils.format.register({
                name = "conform.nvim",
                priority = 100,
                primary = true,
                format = function(buf)
                    local opts = config_utils.opts("conform.nvim")
                    require("conform").format(lazy_utils.merge({}, opts.format, { bufnr = buf }))
                end,
                sources = function(buf)
                    local ret = require("conform").list_formatters(buf)
                    ---@param v conform.FormatterInfo
                    return vim.tbl_map(function(v) return v.name end, ret)
                end,
            })
        end)
    end,
    opts = function()
        ---@class ConformOpts
        local opts = {
            format = {
                timeout_ms = 3000,
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
                lsp_fallback = true, -- not recommended to change
            },
            ---@type table<string, conform.FormatterUnit[]>
            formatters_by_ft = {
                lua = { "stylua" },
                fish = { "fish_indent" },
                sh = { "shfmt" },
                java = { "google-java-format" },
            },
            -- The options you set here will be merged with the builtin formatters.
            -- You can also define any custom formatters here.
            ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
            formatters = {
                injected = { options = { ignore_errors = true } },
                -- # Example of using dprint only when a dprint.json file is present
                -- dprint = {
                --   condition = function(ctx)
                --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                --   end,
                -- },
                --
                -- # Example of using shfmt with extra args
                -- shfmt = {
                --   prepend_args = { "-i", "2", "-ci" },
                -- },
            },
        }
        return opts
    end,
}
