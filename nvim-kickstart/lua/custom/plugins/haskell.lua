return {
    'mrcjkb/haskell-tools.nvim',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    version = '^3',
    config = function ()
        local ht = require('haskell-tools')
        --- Start or attach the LSP client.
        ht.lsp.start()

        --- Stop the LSP client.
        ht.lsp.stop()

        --- Restart the LSP client.
        ht.lsp.restart()

        --- Callback for dynamically loading haskell-language-server settings
        --- Falls back to the `hls.default_settings` if no file is found
        --- or one is found, but it cannot be read or decoded.
        --- @param project_root string? The project root
        ht.lsp.load_hls_settings(project_root)

        --- Evaluate all code snippets in comments
        ht.lsp.buf_eval_all() 
    end
}
