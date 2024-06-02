return {
    ---@param name string
    get_plugin_opts = function(name)
        local plugin = require("lazy.core.config").spec.plugins[name]
        if not plugin then return {} end
        local Plugin = require("lazy.core.plugin")
        return Plugin.values(plugin, "opts", false)
    end,

    ---@param fn fun(...)
    on_very_lazy = function(fn)
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function() fn() end,
        })
    end,
}
