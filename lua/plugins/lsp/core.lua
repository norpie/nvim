-- Core LSP plugins and dependencies
return {
    -- Navbuddy for LSP navigation
    {
        "SmiteshP/nvim-navbuddy",
        lazy = false,
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            'saghen/blink.cmp',
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
            { '<leader>n', '<cmd>Navbuddy<CR>', desc = 'Open Navbuddy' },
        },
        config = function(_, opts)
            require('nvim-navbuddy').setup(opts)

            -- Setup LSP servers
            -- List of servers to enable
            local servers = {
                'lua_ls',
                'cssls',
                'emmet_ls',
                'bashls',
                'html',
                'jsonls',
                'tailwindcss',
                'sqlls',
                'texlab',
                'svelte',
                'taplo',
                'vimls',
                'nil_ls',
                'pyright',
            }

            -- Get capabilities from config.lsp
            local lsp_config = require('config.lsp')
            local capabilities = lsp_config.get_capabilities()

            -- Load and configure each server
            for _, server in ipairs(servers) do
                local config_path = 'lsp.servers.' .. server
                local ok, server_config = pcall(require, config_path)
                if ok then
                    -- Convert root_markers to root_dir function if needed
                    if server_config.root_markers and not server_config.root_dir then
                        local markers = server_config.root_markers
                        server_config.root_dir = function(fname)
                            return vim.fs.root(fname, markers)
                        end
                    end

                    -- Merge with capabilities
                    server_config.capabilities = capabilities

                    -- Configure the server
                    vim.lsp.config(server, server_config)
                else
                    vim.notify('Failed to load config for ' .. server .. ': ' .. server_config, vim.log.levels.ERROR)
                end
            end

            -- Enable all servers at once
            vim.lsp.enable(servers)

            -- Load custom servers
            require('lsp.custom.surrealql')
        end,
    },
    {
        -- Format fallback
        lazy = true,
        'sbdchd/neoformat',
        cmd = 'Neoformat'
    },
}
