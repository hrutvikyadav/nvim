local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true, desc = 'LSP: [g]oto [r]eferences' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: [g]oto [d]efinition' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = true, desc = 'LSP: [g]oto [I]mplementation' })
    --vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {buffer = true, desc = 'LSP: type [D]efinition'})
    vim.keymap.set('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
        { buffer = true, desc = 'LSP: [T]ype Definition' })
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
        { buffer = true, desc = 'LSP: [g]oto [D]eclaration' })

    vim.keymap.set('n', '<leader>Ds', '<cmd>Telescope lsp_document_symbols<cr>',
        { buffer = true, desc = 'LSP: [D]ocument [s]ymbols' })
    vim.keymap.set('n', '<leader>Ws', '<cmd>Telescope lsp_workspace_symbols<cr>',
        { buffer = true, desc = 'LSP: [W]orkspace [s]ymbols' })
end)

lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    --'sumneko_lua',
    'rust_analyzer',
})

-- allow only single server to format per file type - mapped to `gq`
-- lsp.format_mapping('gq', {
--  format_opts = {
--    async = false,
--    timeout_ms = 10000,
--  },
--  servers = {
--    ['lua_ls'] = {'lua'},
--    ['rust_analyzer'] = {'rust'},
-- if you have a working setup with null-ls
-- you can specify filetypes it can format.
-- ['null-ls'] = {'javascript', 'typescript'},
--  }
--})

lsp.setup()
