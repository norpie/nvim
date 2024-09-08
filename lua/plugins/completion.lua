return {
    {
        'hrsh7th/nvim-cmp',
        version = false,
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'petertriho/cmp-git',
            'dmitmel/cmp-cmdline-history',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'L3MON4D3/LuaSnip',
        },
        config = function()
            local cmp = require 'cmp'
            --local lspkind = require('lspkind')
            local lspkind = require 'lspkind'
            lspkind.init {
                symbol_map = {
                    Copilot = '',
                },
            }

            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
                    return false
                end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
            end

            local opts = {
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                        col_offset = -3,
                        side_padding = 0,
                        scrollbar = true,
                    },
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, vim_item)
                        local kind =
                            require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
                        local strings = vim.split(kind.kind, '%s', { trimempty = true })
                        kind.kind = ' ' .. (strings[1] or '') .. ' '
                        kind.menu = '    (' .. (strings[2] or '') .. ')'

                        return kind
                    end,
                    --format = lspkind.cmp_format({
                    --    mode = 'symbol', -- show only symbol annotations
                    --    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    --    ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    --})
                },
                view = {
                    entries = {
                        name = 'custom',
                        selection_order = 'near_cursor',
                    },
                },
                experimental = {
                    ghost_text = { hl_group = 'Comment' },
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
                    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(4),
                    ---@diagnostic disable-next-line: missing-parameter
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Insert },
                },
                sources = cmp.config.sources({
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                    { name = 'crates' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
            }

            cmp.setup(opts)

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' },
                }, {
                    { name = 'buffer' },
                }),
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
                formatting = {
                    format = function(entry, vim_item)
                        local kind =
                            require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 60 }(entry, vim_item)
                        kind.kind = ''
                        kind.menu = ''
                        kind.abbr = string.format('%-64s', kind.abbr)
                        return kind
                    end,
                },
                window = {
                    completion = {
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                        col_offset = -6,
                        side_padding = 7,
                        width = 60,
                    },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = 'path' } },
                    { { name = 'cmdline' } },
                    { { name = 'cmdline_history' } }
                ),
                formatting = {
                    format = function(entry, vim_item)
                        local kind =
                            require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 60 }(entry, vim_item)
                        kind.kind = ''
                        kind.menu = ''
                        kind.abbr = string.format('%-64s', kind.abbr)
                        return kind
                    end,
                },
                window = {
                    completion = {
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                        col_offset = -4,
                        side_padding = 5,
                        width = 60,
                    },
                },
            })
        end,
    },
    {
        'folke/neodev.nvim',
        ft = 'lua',
    },
}
