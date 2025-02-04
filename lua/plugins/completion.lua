return {
    {
        'hrsh7th/nvim-cmp',
        enabled = true,
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
            {
                'windwp/nvim-autopairs',
                event = "InsertEnter",
                config = true
                -- use opts = {} for passing setup options
                -- this is equivalent to setup({}) function
            }
        },
        config = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'
            lspkind.init {
                symbol_map = {
                    Text = "󰰥",
                    Method = "󰰑",
                    Function = "󰯻",
                    Constructor = "󰯲",
                    Copilot = "",
                    Field = "󰯼",
                    Variable = "󰰫",
                    Class = "󰰥",
                    Interface = "󰰄",
                    Module = "󰰐",
                    Property = "󰰙",
                    Unit = "󰯸",
                    Value = "󰰫",
                    Enum = "󰯸",
                    Keyword = "󰰊",
                    Snippet = "󰰢",
                    Color = "󰯲",
                    File = "󰯻",
                    Reference = "󰰟",
                    Folder = "󰯻",
                    EnumMember = "󰯸",
                    Constant = "󰯲",
                    Struct = "󰰥",
                    Event = "󰯻",
                    Operator = "󰰊",
                    TypeParameter = "󰰥",
                },
            }

            vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
            -- local has_words_before = function()
            --     if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
            --         return false
            --     end
            --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            --     return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
            -- end

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
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                        scrollbar = false,
                    },
                    documnentation = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local settings = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = {
                                abbr = 15,
                                kind = 8,
                                menu = 0,
                            },
                            elipsis_character = "…",
                        })
                        local kind = settings(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        -- Add padding to the kind
                        kind.menu = string.format(" [%-7s]", strings[2] or "")
                        kind.kind = " " .. (strings[1] or "") .. " "
                        local kind_length = vim.fn.strdisplaywidth(kind.kind)
                        if strings[2] == "Keyword" or strings[2] == "Variable" then
                            -- set the kind to string of kind_length spaces
                            kind.kind = string.rep(" ", kind_length)
                        end
                        return kind
                    end,
                },
                view = {
                    entries = {
                        selection_order = 'near_cursor',
                        follow_cursor = true,
                    },
                },
                -- experimental = {
                --     ghost_text = { hl_group = 'Comment' },
                -- },
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
                            require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 60 } (entry, vim_item)
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
                            require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 60 } (entry, vim_item)
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

            -- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    {
        'saghen/blink.cmp',
        enabled = false,
        lazy = false, -- lazy loading handled internally
        dependencies = {
            'rafamadriz/friendly-snippets',
            'niuiic/blink-cmp-rg.nvim',
            'Saghen/blink.compat',
            'dmitmel/cmp-digraphs',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',

        opts = {
            keymap = { preset = 'enter' },
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            nerd_font_variant = 'mono',

            accept = {
                auto_brackets = { enabled = true },

                expand_snippet = function(args)
                    require('luasnip').lsp_expand(args.body)
                    vim.cmd '<Plug>luasnip-expand-or-jump'
                end,
            },

            trigger = { signature_help = { enabled = true } },

            sources = {
                completion = {
                    enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep', 'luasnip' },
                },
                providers = {
                    luasnip = {
                        name = 'luasnip',
                        module = 'blink.compat.source',

                        score_offset = 3,

                        opts = {},
                    },
                    digraphs = {
                        name = 'digraphs',
                        module = 'blink.compat.source',

                        score_offset = -3,

                        opts = {
                            cache_digraphs_on_start = true,
                        },
                    },
                    path = {
                        name = 'Path',
                        module = 'blink.cmp.sources.path',
                        score_offset = 3,
                        opts = {
                            trailing_slash = false,
                            label_trailing_slash = true,
                            get_cwd = function(context)
                                return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
                            end,
                            show_hidden_files_by_default = false,
                        },
                    },
                    -- other sources
                    ripgrep = {
                        module = 'blink-cmp-rg',
                        name = 'Ripgrep',
                        opts = {
                            prefix_min_len = 3,
                            get_command = function(_, prefix)
                                return {
                                    'rg',
                                    '--no-config',
                                    '--json',
                                    '--word-regexp',
                                    '--ignore-case',
                                    '--',
                                    prefix .. '[\\w_-]+',
                                    vim.fs.root(0, '.git') or vim.fn.getcwd(),
                                }
                            end,
                            get_prefix = function(_)
                                local col = vim.api.nvim_win_get_cursor(0)[2]
                                local line = vim.api.nvim_get_current_line()
                                local prefix = line:sub(1, col):match '[%w_-]+$' or ''
                                return prefix
                            end,
                        },
                    },
                },
            },
        },
        -- allows extending the enabled_providers array elsewhere in your config
        -- without having to redefining it
        opts_extend = { 'sources.completion.enabled_providers' },
    },
    {
        'folke/neodev.nvim',
        ft = 'lua',
    },
}
