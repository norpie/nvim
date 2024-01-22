return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        keys = {
            { '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, desc = 'lsp format' },
            { '<leader>lh', function() vim.lsp.buf.hover() end },
            { 'gd',         function() vim.lsp.buf.definition() end },
            { 'gD',         function() vim.lsp.buf.declaration() end },
        },
        lazy = true,
        config = function()
            require('lsp.lspconfig').setup()
        end
    },
    {
        'github/copilot.vim',
        event = 'VeryLazy', -- TODO: add better copilot support
        -- {
        --     "zbirenbaum/copilot-cmp",
        --     config = function()
        --         require("copilot_cmp").setup()
        --     end
        -- },
        -- {
        --     "zbirenbaum/copilot.lua",
        --     cmd = "Copilot",
        --     event = "InsertEnter",
        --     config = function()
        --         require("copilot").setup({
        --             suggestion = {
        --                 enabled = false,
        --                 auto_trigger = true
        --             },
        --             panel = {
        --                 enabled = false
        --             },
        --         })
        --     end,
        -- },

    },
    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' },
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('lsp.jdtls').launch()
        end,
        keys = {
            -- nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
            { '<C-S-O>', function() require('jdtls').organize_imports() end },
        }
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        event = 'VeryLazy',
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        'SmiteshP/nvim-navbuddy',
        opts = {
            lsp = {
                auto_attach = true
            }
        },
        keys = {
            { '<leader>n', '<cmd>Navbuddy<CR>' }
        },
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim'
        }
    },
    -- {
    --     'kosayoda/nvim-lightbulb',
    --     event = 'VeryLazy',
    --     config = function()
    --         require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    --     end,
    --     dependencies = {
    --         'neovim/nvim-lspconfig'
    --     }
    -- },
    {
        'saecki/crates.nvim',
        ft = 'toml',
        config = function()
            require('crates').setup()
        end
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('trouble').setup()
        end,
        cmd = {
            'TroubleToggle'
        },
        keys = {
            { '<leader>tt', '<cmd>TroubleToggle<CR>' },
            { '<leader>tq', '<cmd>TroubleToggle quickfix<CR>' },
            { '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>' },
            { '<leader>td', '<cmd>TroubleToggle document_diagnostics<CR>' }
        },
    },
    {

        'weilbith/nvim-code-action-menu',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        keys = {
            { '<leader>q', '<cmd>CodeActionMenu<CR>' }
        }
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { '<leader>r',  '<cmd>GoRename<CR>' },
            { '<leader>f',  function() require("go.format").goimport() end },
            { '<leader>sw', '<cmd>GoFillSwitch<CR>' },
            { '<leader>st', '<cmd>GoFillStruct<CR>' },
            { '<leader>i',  '<cmd>GoIfErr<CR>' },
        },
        config = function()
            require("go").setup({
                luasnip = true,
            })
        end,
        event = { "CmdlineEnter", "VeryLazy" },
        --ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {

        'simrat39/rust-tools.nvim',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        ft = { 'rust' },
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(client, bufnr)
                        require('lsp.lspconfig').on_attach(client, bufnr)
                        vim.keymap.set("n", "<leader>lh", rt.hover_actions.hover_actions, { buffer = bufnr })
                        vim.keymap.set("n", "<leader>lq", rt.code_action_group.code_action_group, { buffer = bufnr })
                        vim.keymap.set("n", "<leader>oc", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
                        vim.keymap.set("n", "<leader>op", rt.parent_module.parent_module, { buffer = bufnr })
                    end,
                    capabilities = require('lsp.lspconfig').capabilities(),
                    cmd = { "ra-multiplex", "client" },
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                                extraArgs = { "--all", "--", "-W", "clippy::all" },
                            },
                            --procMacro = {
                            --    enable = true
                            --},
                        }
                    }
                },
            })
        end,
    },
    {
        'simrat39/symbols-outline.nvim',
        keys = {
            { '<leader>os', '<cmd>SymbolsOutline<CR>' }
        },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('symbols-outline').setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require("mason-lspconfig").setup()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
                callback = function(t)
                    if vim.bo[t.buf].buftype ~= "" then return end
                    local mason_lspconfig = require("mason-lspconfig")
                    local available_servers =
                        mason_lspconfig.get_available_servers({ filetype = t.match })
                    local installed_servers = mason_lspconfig.get_installed_servers()
                    local is_available = false
                    for _, available in ipairs(available_servers) do
                        for _, installed in ipairs(installed_servers) do
                            if available == installed then return end
                        end
                        is_available = true
                    end
                    if is_available then
                        vim.schedule(vim.cmd.LspInstall)
                    end
                end,
            })
        end

    },
    {
        'williamboman/mason.nvim',
        lazy = true,
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
        cmd = {
            "Mason",
            "MasonUpdate",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        }
    }
}
