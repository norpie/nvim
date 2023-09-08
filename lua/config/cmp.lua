local M = {}

function M.setup()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = {
            completeopt = 'menu,menuone,noinsert'
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            --completion = cmp.config.window.bordered(),
            --documentation = cmp.config.window.bordered(),
        },
        view = {
            entries = 'custom',
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-u>'] = cmp.mapping.scroll_docs(4),
            ---@diagnostic disable-next-line: missing-parameter
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = "crates" },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        }),
        experimental = {
            ghost_text = true,
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol', -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            })
        },

    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            { { name = 'path' } },
            { { name = 'cmdline' } },
            { { name = 'cmdline_history' } }
        )
    })
end

return M
