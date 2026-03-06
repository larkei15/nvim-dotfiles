vim.lsp.config('tsserver', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'ts' },
    root_dir = vim.fs.root(0, {'package.json', '.git'}),
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.enable('tsserver')
