return {
    {
        -- 'nvim-neo-tree/neo-tree.nvim',
        -- branch = 'v3.x',
        -- dependencies = {
        --     'nvim-lua/plenary.nvim',
        --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        --     'MunifTanjim/nui.nvim',
        -- },
        -- keys = {
        --     { '<leader>t', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
        -- },
        -- config = function()
        --     require('neo-tree').setup()
        -- end,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        config = function()
            require("dressing").setup({
                input = {
                    start_in_insert = false,
                }
            })
        end
    },
    {
        'famiu/bufdelete.nvim',
        cmd = {
            'Bdelete',
            'Bwipeout'
        }
    },
    {
        "m4xshen/smartcolumn.nvim",
        config = function()
            require("smartcolumn").setup({
                colorcolumn = "100",
                disabled_filetypes = { "help", "text", "markdown", "lazy" },
                custom_colorcolumn = {},
                scope = "window",
            })
        end,
        event = 'VeryLazy',
        opts = {}
    },
    {
        'petertriho/nvim-scrollbar',
        event = 'VeryLazy',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'kevinhwang91/nvim-hlslens'
        },
        config = function()
            require('scrollbar').setup({})
            --require('gitsigns').setup()
            --require('scrollbar.handlers.gitsigns').setup()
            require('scrollbar.handlers.search').setup({
                override_lens = function()
                end,
            })
        end
    },
    {
        "rcarriga/nvim-notify",
    },
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
                views = { -- TODO: fix cmdline suggestions
                    cmdline_popup = {
                        position = {
                            row = 15,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                        border = {
                            style = "none",
                            padding = { 2, 3 },
                        },
                        filter_options = {},
                        win_options = {
                            winhighlight = {
                                NormalFloat = 'Pmenu',
                                FloatBorder = 'Pmenu'
                            },
                        },
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
}
