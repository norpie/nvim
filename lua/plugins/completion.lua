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
        version = '1.*',
        -- build = 'nix run .#default',
        build = "cargo build --release",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'super-tab' },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true
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
                per_filetype = {
                    codecompanion = { "codecompanion" },
                },
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
                                item.score_offset = item.score_offset - 3
                                --  FIXME::
                                --  Copilot has an issue where the completion text in
                                --  the dropdown shows the entire line, lets cut
                                --  off the part until the cursor
                                --  `item.label` contains the completion text
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
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                '<leader>ai',
                function()
                    vim.cmd('CodeCompanion')
                end,
                desc = 'Code companion inline'
            },
            {
                '<leader>aa',
                '<cmd>CodeCompanionActions<cr>',
                desc = 'Trigger Code Companion actions'
            },
            {
                '<leader>ac',
                '<cmd>CodeCompanionChat<cr>',
                desc = 'Open Code Companion chat interface'
            },
            {
                '<leader>am',
                '<cmd>CodeCompanionCmd',
                desc = 'Execute a command in Code Companion'
            },
        },
        cmd = {
            'CodeCompanion',
            'CodeCompanionActions',
            'CodeCompanionChat',
            'CodeCompanionCmd',
        },
        opts = {
            adapters = {
                qwen = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        env = {
                            url = "cmd:ollama-ip",
                        },
                        headers = {
                            ["Content-Type"] = "application/json",
                        },
                        parameters = {
                            sync = true,
                        },
                        schema = {
                            model = {
                                default = "qwen2.5-coder:32b",
                            },
                            num_ctx = {
                                default = 8192,
                            },
                            num_preduct = {
                                default = -1,
                            }
                        }
                    })
                end,
                deepseek = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        env = {
                            url = "cmd:ollama-ip",
                        },
                        headers = {
                            ["Content-Type"] = "application/json",
                        },
                        parameters = {
                            sync = true,
                        },
                        schema = {
                            model = {
                                default = "deepseek-coder-v2:16b-lite-base-q8_0",
                            },
                            num_ctx = {
                                default = 8192,
                            },
                            num_preduct = {
                                default = -1,
                            }
                        }
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "qwen",
                    roles = {
                        ---The header name for the LLM's messages
                        ---@type string|fun(adapter: CodeCompanion.Adapter): string
                        llm = function()
                            return "CodeCompanion"
                        end,

                        ---The header name for your messages
                        ---@type string
                        user = "Me",
                    }
                },
                inline = {
                    adapter = "qwen",
                    keymaps = {
                        accept_change = {
                            modes = { n = "<leader>da" },
                            description = "Accept the suggested change",
                        },
                        reject_change = {
                            modes = { n = "<leader>dr" },
                            description = "Reject the suggested change",
                        },
                    },
                },
            },
            display = {
                diff = {
                    enabled = true,
                    close_chat_at = 240,
                    layout = "vertical",
                    opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                    provider = "mini_diff",
                },
            },
            opts = {
                log_level = "DEBUG",
            },
        }
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
        'L3MON4D3/LuaSnip',
        lazy = true,
        disabled = false,
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
