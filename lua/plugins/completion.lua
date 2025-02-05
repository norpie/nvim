return {
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
        },
        -- version = '*',
        build = "cargo build --release",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'super-tab' },
            completion = {
                trigger = {
                    show_on_blocked_trigger_characters = function()
                        if vim.api.nvim_get_mode().mode == 'c' then return {} end
                        -- return { ' ', '\n', '\t' }
                        return {}
                    end,
                },
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
                kind_icons = {
                    Copilot = "",
                    Text = '󰉿',
                    Method = '󰊕',
                    Function = '󰊕',
                    Constructor = '󰒓',

                    Field = '󰜢',
                    Variable = '󰆦',
                    Property = '󰖷',

                    Class = '󱡠',
                    Interface = '󱡠',
                    Struct = '󱡠',
                    Module = '󰅩',

                    Unit = '󰪚',
                    Value = '󰦨',
                    Enum = '󰦨',
                    EnumMember = '󰦨',

                    Keyword = '󰻾',
                    Constant = '󰏿',

                    Snippet = '󱄽',
                    Color = '󰏘',
                    File = '󰈔',
                    Reference = '󰬲',
                    Folder = '󰉋',
                    Event = '󱐋',
                    Operator = '󰪚',
                    TypeParameter = '󰬛',
                }
            },
            signature = { enabled = true },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
                providers = {
                    buffer = {
                        opts = {
                            -- or (recommended) filter to only "normal" buffers
                            get_bufnrs = function()
                                return vim.tbl_filter(function(bufnr)
                                    return vim.bo[bufnr].buftype == ''
                                end, vim.api.nvim_list_bufs())
                            end
                        }
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 50,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                    },
                },
            },
        },
        opts_extend = { "sources.default" }
    },
    {
        'terrortylor/nvim-comment',
        keys = {
            { '<leader>c', '<cmd>CommentToggle<cr>',                       desc = 'Comment toggle' },
            { '<leader>c', ':<C-u>call CommentOperator(visualmode())<CR>', mode = 'x' },
        },
        config = function()
            require('nvim_comment').setup {
                create_mappings = false,
                hook = function()
                    require('ts_context_commentstring.internal').update_commentstring()
                end,
            }
        end,
    },
    {
        event = "InsertEnter",
        'giuxtaposition/blink-cmp-copilot',
        dependencies = {
            {
                'zbirenbaum/copilot.lua',
                dependencies = {
                    'saghen/blink.cmp',
                },
                config = function()
                    vim.api.nvim_create_autocmd('User', {
                        pattern = 'BlinkCmpMenuOpen',
                        callback = function()
                            require("copilot.suggestion").dismiss()
                            vim.b.copilot_suggestion_hidden = true
                        end,
                    })
                    vim.api.nvim_create_autocmd('User', {
                        pattern = 'BlinkCmpMenuClose',
                        callback = function()
                            vim.b.copilot_suggestion_hidden = false
                        end,
                    })


                    require("copilot").setup({
                        suggestion = {
                            enabled = true,
                            auto_trigger = true,
                            keymap = {
                                accept = "<Tab>",
                            }
                        },
                        panel = {
                            enabled = false,
                        },
                    })
                end
            }
        },
    }
}
