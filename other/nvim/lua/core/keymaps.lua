local te_buf = nil
local te_win_id = nil

local function openTerminal()
    if vim.fn.bufexists(te_buf) ~= 1 then
        vim.api.nvim_command("au TermOpen * setlocal nonumber norelativenumber signcolumn=no")
        vim.api.nvim_command("sp | winc J | res 10 | te")
        te_win_id = vim.fn.win_getid()
        te_buf = vim.fn.bufnr("%")
    elseif vim.fn.win_gotoid(te_win_id) ~= 1 then
        vim.api.nvim_command("sb " .. te_buf .. "| winc J | res 10")
        te_win_id = vim.fn.win_getid()
    end
    vim.api.nvim_command("startinsert")
end

local function hideTerminal()
    if vim.fn.win_gotoid(te_win_id) == 1 then vim.api.nvim_command("hide") end
end

local function ToggleTerminal()
    if vim.fn.win_gotoid(te_win_id) == 1 then
        hideTerminal()
    else
        openTerminal()
    end
end
local terminal = require("modules.terminal")

vim.keymap.set({ "i", "n", "t" }, "<C-s>", function() ToggleTerminal() end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>dP", '"_dP')
vim.keymap.set("x", "<leader>xP", '"_xP')
vim.keymap.set("x", "<leader>dp", '"_dp')
vim.keymap.set("x", "<leader>xp", '"_xp')
vim.keymap.set({ "x", "n" }, "<leader>xx", '"_x')
vim.keymap.set({ "x", "n" }, "<leader>dd", '"_d')
vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>cmx", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
