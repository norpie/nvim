return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('config/lsp').setup()
        end
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
        opts = {
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
            { '<Leader>n', '<cmd>Navbuddy<CR>' }
        },
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim'
        }
    },
    {
        'kosayoda/nvim-lightbulb',
        event = 'VeryLazy',
        config = function()
            require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
        end,
        dependencies = {
            'neovim/nvim-lspconfig'
        }
    },
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
            { '<Leader>tt', '<cmd>TroubleToggle<CR>' },
            { '<Leader>tq', '<cmd>TroubleToggle quickfix<CR>' },
            { '<Leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>' },
            { '<Leader>td', '<cmd>TroubleToggle document_diagnostics<CR>' }
        },
    },
    {

        'weilbith/nvim-code-action-menu',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        keys = {
            { '<Leader>q', '<cmd>CodeActionMenu<CR>' }
        }
    },
    {

        'simrat39/rust-tools.nvim',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        ft = {
            'rust'
        }
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
        event = 'VeryLazy',
        dependencies = { 'williamboman/mason.nvim' },
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
