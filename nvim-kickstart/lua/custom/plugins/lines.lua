-- return {
--     "shellRaining/hlchunk.nvim",
--     event = { "UIEnter" },
--     config = function()
--         require("hlchunk").setup({
--             indent = {
--                 chars = { "│", "│", "│", "│", }, -- more code can be found in https://unicodeplus.com/
--
--                 style = {
--                     "#D3D3D3",
--                 },
--             },
--             blank = {
--                 enable = false,
--             }
--         })
--     end
-- }
--
return {
    'shellRaining/hlchunk.nvim',
    event = { "UIEnter" },
    config = function ()
        require("hlchunk").setup({
            chunk = {
                enable = false,
                use_treesitter = true,
                chars = {
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "┌",
                    left_bottom = "└",
                    right_arrow = "─",
                },
                style = {
                    { fg = "#4572e6" },
                    { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
                },
            },
            indent = {
                enable = true,
                use_treesitter = true,
                chars = {
                    "│",
                },
                style = {
                    -- "#84d194",
                    -- "#FF7F00",
                    -- "#6e49b8",
                    -- "#63d6d4",
                    -- "#ebdc6a",
                    -- "#4572e6",
                    -- "#8B00FF",
                    { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") }
                },
            },
            blank = {
                enable = false,
                chars = {
                    "․",
                },
                style = {
                    vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
                },
            },
        })
    end
}
