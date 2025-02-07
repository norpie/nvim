return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                ---- you can enable a preset for easier configuration
                presets = {
                    --    bottom_search = true,        -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    --    long_message_to_split = true, -- long messages will be sent to a split
                    --    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    --    lsp_doc_border = false,       -- add a border to hover docs and signature help
                    inc_rename = true

                },
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = 'Agent service not initialized' },
                            },
                        },
                        opts = { skip = true },
                    },
                },
                views = { -- TODO: fix cmdline suggestions
                    cmdline_popup = {
                        position = {
                            row = 15,
                            col = "50%",
                        },
                        --     size = {
                        --         width = 60,
                        --         height = "auto",
                        --     },
                        --     border = {
                        --         style = "none",
                        --         padding = { 2, 3 },
                        --     },
                        --     filter_options = {},
                        --     win_options = {
                        --         winhighlight = {
                        --             NormalFloat = 'Pmenu',
                        --             FloatBorder = 'Pmenu'
                        --         },
                        --    },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = 10,
                        },
                        border = {
                            style = "none",
                            padding = { 2, 3 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                        --win_options = {
                        --    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        --},
                    },
                },
            })
        end
    },
    {
        'akinsho/bufferline.nvim',
        event = "UIEnter",
        version = "*",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            local bufferline = require('bufferline')
            bufferline.setup {
                options = {
                    -- count, level, diagnostics_dict, context
                    diagnostics_indicator = function(count, level, _, _)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end
                }
            }
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'AndreM222/copilot-lualine',
        },
        event = "UIEnter",
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto', -- based on current vim colorscheme
                    -- not a big fan of fancy triangle separators
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    -- left
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'copilot', },
                    lualine_c = { 'diff', 'diagnostics' },
                    -- right
                    lualine_x = { '' },
                    lualine_y = { 'filetype' },
                    lualine_z = { '' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            })
        end
    },
    {
        "ghillb/cybu.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<s-tab>", "<cmd>CybuPrev<cr>" },
            { "<tab>",   "<cmd>CybuNext<cr>" }
        },
        config = function()
            require('cybu').setup()
        end,
    },
    {
        'mawkler/modicator.nvim',
        event = 'ModeChanged',
        opts = {
            show_warnings = true,
        }
    },
    {
        'jinh0/eyeliner.nvim',
        event = 'VeryLazy',
        config = function()
            require('eyeliner').setup {
                highlight_on_key = false, -- show highlights only after keypress
                dim = false               -- dim all other characters if set to true (recommended!)
            }
        end
    },
    {
        'lewis6991/satellite.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'famiu/bufdelete.nvim',
        cmd = {
            'Bdelete',
            'Bwipeout'
        }
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        config = function()
            require("dressing").setup({
                input = {
                    start_mode = "normal",
                }
            })
        end
    },
    {
        "folke/todo-comments.nvim",
        event = "UIEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        'catgoose/nvim-colorizer.lua',
        event = 'BufReadPre',
        opts = {
            tailwind = true
        }
    },
    {
        'Bekaboo/deadcolumn.nvim',
        event = 'UIEnter',
        opts = {}
    },
    {
        'Bekaboo/dropbar.nvim',
        event = 'UIEnter',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
    },
    {
        {
            'stevearc/oil.nvim',
            ---@module 'oil'
            ---@type oil.SetupOpts
            opts = {},
            dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
            lazy = false,
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local highlight = {
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
                "RainbowDelimiterRed",
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
                vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup {
                scope = {
                    enabled = true,
                    highlight = highlight,
                    show_exact_scope = true,
                },
                indent = {
                    char = "▏",
                },
            }
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    },
    {
        "chrisgrieser/nvim-spider",
        keys = {
            { 'w', function() require('spider').motion('w') end },
            { 'w', function() require('spider').motion('w') end, mode = 'x' },
            { 'e', function() require('spider').motion('e') end },
            { 'e', function() require('spider').motion('e') end, mode = 'x' },
            { 'b', function() require('spider').motion('b') end },
            { 'b', function() require('spider').motion('b') end, mode = 'x' },
        }
    }
}
