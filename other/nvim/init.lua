require("core.keymaps")
require("core.opts")
local data = vim.fn.stdpath("data")
local lazypath = data .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("plugins")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("main-highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank({
        higroup = "MoreMsg",
        on_visual = true
    }) end,
})
