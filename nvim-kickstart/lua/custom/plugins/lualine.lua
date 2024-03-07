return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    options = {
    },

    config = function ()
        require('lualine').setup({
            options = {
                theme  = 'codedark',
                component_separators = { left = " ", right = " " },
                section_separators = { left = " ", right = " " },
                icons_enabled = true,
                -- local symbols = {
                --     unix = '', -- e712
                --     dos = '', -- e70f
                --     mac = '', -- e711
                -- }
            },
        })
    end
}
