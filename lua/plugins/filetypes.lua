return {
    { -- Used in latex for writing math
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>me', function() require("nabla").enable_virt() end,  desc = 'Enable scientific math' },
            { '<leader>md', function() require("nabla").disable_virt() end, desc = 'Disable scientific math' },
            { '<leader>mh', function() require("nabla").popup() end,        desc = "Popup scientific math" },
        }
    },
    { -- Markdown preview
        'OXY2DEV/markview.nvim',
        ft = { 'markdown' },
    },
    {
        'epwalsh/obsidian.nvim',
        event = { 'BufReadPre ' .. vim.fn.expand '~' .. '/notes/**.md' },
        dependencies = { 'nvim-lua/plenary.nvim', },
        -- ["<leader>d"] = vim.cmd('ObsidianFollowLink'),
        -- ["<leader>b"] = vim.cmd('ObsidianBacklinks'),
        -- ["<leader>n"] = vim.cmd('ObsidianNew'),
        -- ["<leader>s"] = vim.cmd('ObsidianSearch'),
        -- ["<C-P>"] = vim.cmd('ObsidianQuickSwitch'),
        -- ["<leader>t"] = vim.cmd('ObsidianTemplate'),
        keys = {
            { '<leader>d', function() vim.cmd('ObsidianFollowLink') end,  desc = 'Follow link' },
            { '<leader>b', function() vim.cmd('ObsidianBacklinks') end,   desc = 'Backlinks' },
            { '<leader>n', function() vim.cmd('ObsidianNew') end,         desc = 'New note' },
            { '<leader>s', function() vim.cmd('ObsidianSearch') end,      desc = 'Search' },
            { '<C-P>',     function() vim.cmd('ObsidianQuickSwitch') end, desc = 'Quick switch' },
            { '<leader>t', function() vim.cmd('ObsidianTemplate') end,    desc = 'Template' },
        },
        opts = {
            dir = '~/notes', -- no need to call 'vim.fn.expand' here
            new_notes_location = 'current_dir',
            wiki_link_func = function(opts)
                return require("obsidian.util").wiki_link_id_prefix({
                    prepend_note_id = true,
                })
            end,
            completion = {
                nvim_cmp = false,
                min_chars = 2,
            },
            workspaces = {
                {
                    name = "notes",
                    path = "~/notes",
                }
            }
        },
    },
}
