return {
    "epwalsh/obsidian.nvim",
    lazy = true,
    --event = { "BufReadPre path/to/my-vault/**.md" },
    event = { "BufReadPre " .. vim.fn.expand "~" .. "/notes/**.md" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
        -- Required.
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
        'nvim-telescope/telescope.nvim',
        'sbdchd/neoformat',
    },
    opts = {
        dir = "~/notes", -- no need to call 'vim.fn.expand' here
        -- Optional, completion.
        completion = {
            -- If using nvim-cmp, otherwise set to false
            nvim_cmp = true,
            -- Trigger completion at 2 chars
            min_chars = 2,
            -- Where to put new notes created from completion. Valid options are
            --  * "current_dir" - put new notes in same directory as the current buffer.
            --  * "notes_subdir" - put new notes in the default notes subdirectory.
            new_notes_location = "current_dir",

            -- Whether to add the output of the node_id_func to new notes in autocompletion.
            -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
            prepend_note_id = true
        },
        -- Optional, key mappings.
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            --["gd"] = require("obsidian.mapping").gf_passthrough(),
        }
    },
    setup = function()
        vim.keymap.set("n", "<Leader>d", function()
            return "<cmd>ObsidianFollowLink<CR>"
        end, { noremap = false, expr = true })

        vim.keymap.set("n", "<Leader>b", function()
            return "<cmd>ObsidianBacklinks<CR>"
        end, { noremap = false, expr = true })

        vim.keymap.set("n", "<Leader>n", function()
            return "<cmd>ObsidianNew<CR>"
        end, { noremap = false, expr = true })

        vim.keymap.set("n", "<Leader>s", function()
            return "<cmd>ObsidianSearch<CR>"
        end, { noremap = false, expr = true })

        vim.keymap.set("n", "<Leader>f", function()
            return "<cmd>Neoformat<CR>"
        end, { noremap = false, expr = true })

        vim.keymap.set("n", "<C-P>", function()
            return "<cmd>ObsidianQuickSwitch<CR>"
        end, { noremap = false, expr = true })

        vim.keymap.set("n", "<Leader>t", function()
            return "<cmd>ObsidianTemplate<CR>"
        end, { noremap = false, expr = true })
    end
}
