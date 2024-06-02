local excluded_ft = {
    "dashboard",
    "neo-tree",
    "trouble",
    "mason",
    "notify",
    "lazyterm",
    "TelescopeResults",
    "query",
    "tsplayground",
    "lazy",
    "lsp-installer",
    "markdown",
    "txt",
    "text",
    "alpha",
    "NvimTree",
    "undotree",
    "diff",
    "fugitive",
    "fugitiveblame",
    "Outline",
    "SidebarNvim",
    "packer",
    "lsp-installer",
    "TelescopePrompt",
    "help",
    "telescope",
    "lspinfo",
    "Trouble",
    "null-ls-info",
    "quickfix",
    "chadtree",
    "fzf",
    "NeogitStatus",
    "terminal",
    "console",
    "term://*",
    "Term://*",
    "toggleterm",
    "qf",
    "prompt",
    "noice",
    "",
}
return {
    {
        "folke/tokyonight.nvim",
    },
    {
        "EdenEast/nightfox.nvim",
        init = function()
            vim.cmd.colorscheme("carbonfox")
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        version = "3.5.3",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false, },
            exclude = {
                buftypes = {
                    "terminal",
                    "nofile",
                },
                filetypes = excluded_ft
            },
        },
        main = "ibl",
    },
    {
        "echasnovski/mini.indentscope",
        opts = {
            draw = {
                delay = 0,
                animation = function()
                    return 0
                end,
                priority = 2,
            },
            mappings = {
                object_scope = "<leader>zz",
                object_scope_with_border = "<leader>zx",
                goto_top = "[i",
                goto_bottom = "]i",
            },
            options = {
                border = "both",
                indent_at_cursor = true,
                try_as_border = true,
            },
            symbol = "│",
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = excluded_ft,
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- vim.cmd("highlight RainbowDelimiterRed    guifg=#fa4d56")
            vim.cmd("highlight RainbowDelimiterYellow guifg=#fccd27")
            vim.cmd("highlight RainbowDelimiterBlue   guifg=#bae6ff")
            vim.cmd("highlight RainbowDelimiterOrange guifg=#ff832b")
            vim.cmd("highlight RainbowDelimiterGreen  guifg=#b6f6c8")
            vim.cmd("highlight RainbowDelimiterViolet guifg=#ff57a0")
            vim.cmd("highlight RainbowDelimiterCyan   guifg=#25cac8")
            local rainbow_delimiters = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    -- lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    -- "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
            vim.keymap.set("n", "<leader>rr", function ()
                rainbow_delimiters.toggle(vim.api.nvim_get_current_buf())
            end)
            -- rainbow_delimiters.setup({
            -- })
            --
            --
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = false, -- "Name" codes like Blue or blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    AARRGGBB = true, -- 0xAARRGGBB hex codes
                    rgb_fn = false, -- CSS rgb() and rgba() functions
                    hsl_fn = false, -- CSS hsl() and hsla() functions
                    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
                    virtualtext = "■",
                    -- update color values even if buffer is not focused
                    -- example use: cmp_menu, cmp_docs
                    always_update = false,
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("which-key").setup()

            -- Document existing key chains
            require("which-key").register({
                ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
                ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
                ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
                ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
                ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
                ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
                ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
            })
            -- visual mode
            require("which-key").register({
                ["<leader>h"] = { "Git [H]unk" },
            }, { mode = "v" })
        end,
    }
}
