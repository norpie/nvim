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
                    lualine_b = { 'branch', '', 'diagnostics' },
                    lualine_c = { 'filename' },
                    -- right
                    lualine_x = { '' },
                    lualine_y = { 'filetype' },
                    lualine_z = { '' }
                },
                inactive_sections = {
                    lualine_a = { 'filename' },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = { 'location' },
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
