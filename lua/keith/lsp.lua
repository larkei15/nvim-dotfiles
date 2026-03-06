vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('zls')

local function on_lsp_attach(client, bufnr)
    vim.b.saved_cursor_word = ''

    local highlight_group = vim.api.nvim_create_augroup('LSPHighlightCursorGroup', { clear = true })

    --local function lsp_highlight()
        --    if client.server_capabilities.documentHighlightProvider then
        --        vim.lsp.buf.document_highlight()
        --    end
        --end

        local function check_and_clear_highlight()
            --local current_word = vim.fn.expand('<cword>')

            --if current_word ~= vim.b.saved_cursor_word then
            --    vim.lsp.buf.clear_references()
            --    vim.b.saved_cursor_word = current_word
            --end

            --if client.server_capabilities.documentHighlightProvider then
            --    vim.lsp.buf.document_highlight()
            --end

            -- 1. Always clear previous highlights immediately on cursor move
            vim.lsp.buf.clear_references()

            local current_word = vim.fn.expand('<cword>')

            -- Check if it's a new word AND if the client supports highlighting
            if current_word ~= vim.b.saved_cursor_word and client.server_capabilities.documentHighlightProvider then

                -- 2. Send the LSP request for the new word
                -- We use an on_result callback to handle the timing issue
                vim.lsp.buf.document_highlight({
                    -- This callback runs ONLY after the server successfully responds
                    on_result = function()
                        -- 3. ONLY NOW we update our tracker variable
                        -- This ensures 'saved_cursor_word' matches the word that is currently highlighted
                        vim.b.saved_cursor_word = current_word
                    end,
                })
            end
        end

        vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
            group = highlight_augroup,
            buffer = bufnr,
            callback = check_and_clear_highlight,
        })

        --vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
            --    group = highlight_augroup,
            --    buffer = bufnr,
            --    callback = lsp_highlight,
            --})

            vim.api.nvim_create_autocmd('BufLeave', {
                group = highlight_augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.clear_references()
                end,
            })
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.supports_method('textDocument/completion') then
                    -- This is the specific line that enables "as-you-type"
                    --vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                end
                on_lsp_attach(client, args.buf)
            end,
        })

        --autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        --autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        --autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

        --vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            --    pattern = '*',
            --    command = 'lua vim.lsp.buf.document_highlight()'
            --})
            --
            --vim.api.nvim_create_autocmd('CursorMoved', {
                --    pattern = '*',
                --    command = 'lua vim.lsp.buf.clear_references()'
                --})

                -- menu: use a popup menu to show possible completions
                -- menuone: use the popup menu even if there is only one match
                -- noselect: do not select a match in the menu, force the user to choose
                vim.opt.completeopt = { "menu", "menuone", "noselect" }

                vim.lsp.buf.document_highlight()
                -- Set up nvim-cmp
                local cmp = require('cmp')

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body) -- For LuaSnip users
                        end,
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger completion
                        ['<C-x>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' }, -- LSP completion
                        { name = 'luasnip' },  -- Snippets
                    }, {
                        { name = 'buffer' },   -- Text within current buffer
                        { name = 'path' },     -- File system paths
                    })
                })

                -- 1. Get the completion capabilities from nvim-cmp
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                -- 2. Apply these capabilities to EVERY server by default
                vim.lsp.config('*', {
                    capabilities = capabilities,
                })
