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
        config = function()
            vim.keymap.set('n', '<leader>d', '<cmd>ObsidianFollowLink<CR>',
                { noremap = true, silent = true, desc = 'Follow link' })
            vim.keymap.set('n', '<leader>b', '<cmd>ObsidianBacklinks<CR>',
                { noremap = true, silent = true, desc = 'Backlinks' })
            vim.keymap.set('n', '<leader>n', '<cmd>ObsidianNew<CR>', { noremap = true, silent = true, desc = 'New note' })
            vim.keymap.set('n', '<leader>s', '<cmd>ObsidianSearch<CR>',
                { noremap = true, silent = true, desc = 'Search' })
            vim.keymap.set('n', '<C-P>', '<cmd>ObsidianQuickSwitch<CR>',
                { noremap = true, silent = true, desc = 'Quick switch' })
            vim.keymap.set('n', '<leader>t', '<cmd>ObsidianTemplate<CR>',
                { noremap = true, silent = true, desc = 'Template' })

            require('obsidian').setup({
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
            })
        end,
    },
}
