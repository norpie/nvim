return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'xzbdmw/colorful-menu.nvim',
            'L3MON4D3/LuaSnip',
            {
                "fang2hou/blink-copilot",
                dependencies = {
                    {
                        'zbirenbaum/copilot.lua',
                        opts = {
                            suggestion = { enabled = false },
                            panel = { enabled = false },
                            filetypes = {
                                markdown = true,
                                help = true,
                            },
                        }
                    },
                },
                opts = {
                    max_completions = 1, -- Global default for max completions
                    max_attempts = 2,    -- Global default for max attempts
                }
            },
        },
        version = '*',
        -- build = "cargo build --release",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'super-tab' },
            completion = {
                list = {
                    selection = {
                        auto_insert = false
                    },
                },
                trigger = {
                    show_on_blocked_trigger_characters = function()
                        if vim.api.nvim_get_mode().mode == 'c' then return {} end
                        -- return { ' ', '\n', '\t' }
                        return {}
                    end,
                },
                menu = {
                    direction_priority = { 'n', 's' },
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
                    show_without_selection = true,
                },
            },
            snippets = { preset = 'luasnip' },
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
            sources = {
                min_keyword_length = 0,
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
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                                --  FIXME::
                                --  Copilot has an issue where the completion text in
                                --  the dropdown shows the entire line, lets cut
                                --  off the part until the cursor
                                --  `item.label` contains the completion text
                                --  local line_content = vim.api.nvim_get_current_line()
                                --  print(line_content)
                                --  print(item.label)
                                --  item.label = item.label:sub(1, #line_content - vim.fn.col('.') + 1)
                            end
                            return items
                        end,
                    },
                    -- copilot = {
                    --     name = "copilot",
                    --     module = "blink-cmp-copilot",
                    --     score_offset = 100,
                    --     async = true,
                    --
                    -- },
                },
            }
        },
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
    -- {
    --     event = "InsertEnter",
    --     'giuxtaposition/blink-cmp-copilot',
    --     dependencies = {
    --         {
    --             'zbirenbaum/copilot.lua',
    --             dependencies = {
    --                 'saghen/blink.cmp',
    --             },
    --             keys = {
    --                 {
    --                     '<Tab>',
    --                     function()
    --                         if require("copilot.suggestion").is_visible() then
    --                             require("copilot.suggestion").accept()
    --                             return
    --                         else
    --                             return "<Tab>"
    --                         end
    --                     end,
    --                     mode = 'i',
    --                     desc = 'Accept copilot suggestion',
    --                     expr = true,
    --                     noremap = true,
    --                 },
    --             },
    --             config = function()
    --                 -- vim.api.nvim_create_autocmd('User', {
    --                 --     pattern = 'BlinkCmpMenuOpen',
    --                 --     callback = function()
    --                 --         require("copilot.suggestion").dismiss()
    --                 --         vim.b.copilot_suggestion_hidden = true
    --                 --     end,
    --                 -- })
    --                 -- vim.api.nvim_create_autocmd('User', {
    --                 --     pattern = 'BlinkCmpMenuClose',
    --                 --     callback = function()
    --                 --         vim.b.copilot_suggestion_hidden = false
    --                 --     end,
    --                 -- })
    --
    --                 require("copilot").setup({
    --                     suggestion = {
    --                         enabled = false,
    --                         auto_trigger = false,
    --                     },
    --                     panel = {
    --                         enabled = false,
    --                     },
    --                     filetypes = {
    --                         yaml = true,
    --                         markdown = true,
    --                     }
    --                 })
    --             end
    --         }
    --     },
    -- },
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        version = "v2.*",
        keys = {
            { '<Leader>se', ':edit! ~/.config/nvim/lua/plugins/completion.lua<CR>', desc = 'Edit snippets' },
        },
        config = function()
            local ls = require("luasnip")
            -- some shorthands...
            local s = ls.snippet
            local sn = ls.snippet_node
            local t = ls.text_node
            local i = ls.insert_node
            local f = ls.function_node
            local c = ls.choice_node
            local d = ls.dynamic_node
            local r = ls.restore_node
            local l = require("luasnip.extras").lambda
            local rep = require("luasnip.extras").rep
            local p = require("luasnip.extras").partial
            local m = require("luasnip.extras").match
            local n = require("luasnip.extras").nonempty
            local dl = require("luasnip.extras").dynamic_lambda
            local fmt = require("luasnip.extras.fmt").fmt
            local fmta = require("luasnip.extras.fmt").fmta
            local types = require("luasnip.util.types")
            local conds = require("luasnip.extras.conditions")
            local conds_expand = require("luasnip.extras.conditions.expand")

            -- Somewhere in your Neovim startup, e.g. init.lua
            ls.config.set_config({
                -- Setting LuaSnip config

                -- Enable autotriggered snippets
                enable_autosnippets = true,

                -- Use key to trigger visual selection
                store_selection_keys = "<C-S>",
            })

            vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })

            local function replace_keycodes(c)
                return vim.api.nvim_replace_termcodes(c, true, true, true)
            end

            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

            -- args is a table, where 1 is the text in Placeholder 1, 2 the text in
            -- placeholder 2,...
            local function copy(args)
                return args[1]
            end

            ls.add_snippets("rust", {
                s("pre", {
                    t("use crate::prelude::*;")
                }),
            })
        end,
    },
}
