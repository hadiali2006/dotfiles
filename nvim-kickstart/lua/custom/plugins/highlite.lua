return {'Iron-E/nvim-highlite',
    config = function(_, opts)
        -- OPTIONAL: setup the plugin. See "Configuration" for information
        require('highlite').setup {generator = {plugins = {vim = false}, syntax = false}}

        -- or one of the alternate colorschemes (see the "Built-in Colorschemes" section)
        --vim.api.nvim_command 'colorscheme highlite-molokai'
    end,
    lazy = false,
    priority = math.huge,
    version = '^4.0.0',
}
