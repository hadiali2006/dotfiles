return {
    {
        "willothy/flatten.nvim",
        config = true,
        lazy = false,
        priority = 1001,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        "altermo/ultimate-autopair.nvim",
        opts = {},
        init = function()
            vim.keymap.set({ "n", "i" }, "<C-p>", require("ultimate-autopair").toggle, { desc = "Toggle AutoPair" })
        end,
    },
    {
        "echasnovski/mini.move",
        opts = {
            mappings = {
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },
            options = {
                reindent_linewise = true,
            },
        },
    },
    {
        "echasnovski/mini.splitjoin",
        opts = {
            mappings = {
                toggle = "gS",
                split = "",
                join = "",
            },

            -- Detection options: where split/join should be done
            detect = {
                -- Array of Lua patterns to detect region with arguments.
                -- Default: { '%b()', '%b[]', '%b{}' }
                brackets = nil,

                -- String Lua pattern defining argument separator
                separator = ",",

                -- Array of Lua patterns for sub-regions to exclude separators from.
                -- Enables correct detection in presence of nested brackets and quotes.
                -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
                exclude_regions = nil,
            },

            -- Split options
            split = {
                hooks_pre = {},
                hooks_post = {},
            },

            -- Join options
            join = {
                hooks_pre = {},
                hooks_post = {},
            },
        },
    },
    {
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        "echasnovski/mini.ai",
        opts = {
            mappings = {
                around = "a",
                inside = "i",

                around_next = "an",
                inside_next = "in",
                around_last = "al",
                inside_last = "il",

                goto_left = "g[",
                goto_right = "g]",
            },
            n_lines = 500,

            -- How to search for object (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
            search_method = "cover_or_next",

            -- Whether to disable showing non-error feedback
            silent = false,
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({}) end,
    },
    {
        "echasnovski/mini.statusline",
        config = function()
            local s = require("mini.statusline")
            s.setup({
                content = {
                    active = nil,
                    inactive = nil,
                },
                use_icons = vim.g.have_nerd_font,
                set_vim_settings = false,
            })
            s.section_location = function() return "%2l:%-2v" end
        end,
    },
    {
        "echasnovski/mini.align",
        opts = {
            mappings = {
                start = "ga",
                start_with_preview = "gA",
            },
            options = {
                split_pattern = "",
                justify_side = "left",
                merge_delimiter = "",
            },
            steps = {
                pre_split = {},
                split = nil,
                pre_justify = {},
                justify = nil,
                pre_merge = {},
                merge = nil,
            },
            silent = false,
        },
    },
    {

        "ggandor/leap.nvim",
        config = function()
            vim.keymap.set({ "n", "x", "o" }, "<leader>lf", "<Plug>(leap-forward)", { desc = "Leap forward" })
            vim.keymap.set({ "n", "x", "o" }, "<leader>lb", "<Plug>(leap-backward)", { desc = "Leap backward" })
            vim.keymap.set({ "n", "x", "o" }, "<leader>lw", "<Plug>(leap-from-window)", { desc = "Leap from window" })
        end,
    },
}
