return {
    { -- Additioanl text objects
        'wellle/targets.vim',
        event = "VeryLazy",
    },
    { -- Surround text objects with quotes, brackets, etc.
        "kylechui/nvim-surround",
        dependencies = {
            {
                "roobert/surround-ui.nvim",
                dependencies = {
                    "folke/which-key.nvim",
                },
                config = function()
                    require("surround-ui").setup({
                        root_key = "S"
                    })
                end,
            }
        },
        event = "VeryLazy",
        opts = {
            keymaps = {
                visual = "s",
                normal = "s"
            }
        }
    },
    { -- Clean up trailing whitespace
        'McAuleyPenney/tidy.nvim',
        event = 'VeryLazy',
        config = function()
            require('tidy').setup()
        end,
    },
    { -- Auto pairs for brackets, quotes, etc.
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    { -- Possiblity to view undo history in a tree
        'mbbill/undotree',
        event = 'VeryLazy',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle undotree' }
        }
    },
    { -- Make undo history more resilient
        'kevinhwang91/nvim-fundo',
        event = 'VeryLazy',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        build = function() require('fundo').install() end,
        opts = {}
    },
    { -- Zen mode
        'folke/zen-mode.nvim',
        keys = {
            { '<Leader>z', '<cmd>ZenMode<CR>', { silent = true } }

        },
        dependencies = {
            'folke/twilight.nvim',
        },
        opts = {
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
                vim.opt.wrap = true
                vim.opt.linebreak = true
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                vim.opt.wrap = false
                vim.opt.linebreak = false
            end,
        }
    },
    { -- Make directories when saving a file
        'jghauser/mkdir.nvim',
        event = 'VeryLazy',
    },
    { -- How many cursors do you want?
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        event = "VeryLazy",
        config = function()
            local mc = require("multicursor-nvim")

            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({ "n", "v" }, "<up>",
                function() mc.lineAddCursor(-1) end)
            set({ "n", "v" }, "<down>",
                function() mc.lineAddCursor(1) end)
            set({ "n", "v" }, "<leader><up>",
                function() mc.lineSkipCursor(-1) end)
            set({ "n", "v" }, "<leader><down>",
                function() mc.lineSkipCursor(1) end)

            -- Add or skip adding a new cursor by matching word/selection
            set({ "n", "v" }, "<leader>n",
                function() mc.matchAddCursor(1) end)
            set({ "n", "v" }, "<leader>s",
                function() mc.matchSkipCursor(1) end)
            set({ "n", "v" }, "<leader>N",
                function() mc.matchAddCursor(-1) end)
            set({ "n", "v" }, "<leader>S",
                function() mc.matchSkipCursor(-1) end)

            -- Add all matches in the document
            set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

            -- You can also add cursors with any motion you prefer:
            -- set("n", "<right>", function()
            --     mc.addCursor("w")
            -- end)
            -- set("n", "<leader><right>", function()
            --     mc.skipCursor("w")
            -- end)

            -- Rotate the main cursor.
            set({ "n", "v" }, "<left>", mc.nextCursor)
            set({ "n", "v" }, "<right>", mc.prevCursor)

            -- Delete the main cursor.
            set({ "n", "v" }, "<leader>x", mc.deleteCursor)

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse)

            -- Easy way to add and remove cursors using the main cursor.
            set({ "n", "v" }, "<c-q>", mc.toggleCursor)

            -- Clone every cursor and disable the originals.
            set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

            set("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <esc> handler.
                end
            end)

            -- bring back cursors if you accidentally clear them
            set("n", "<leader>gv", mc.restoreCursors)

            -- Align cursor columns.
            set("n", "<leader>a", mc.alignCursors)

            -- Split visual selections by regex.
            set("v", "S", mc.splitCursors)

            -- Append/insert for each line of visual selections.
            set("v", "I", mc.insertVisual)
            set("v", "A", mc.appendVisual)

            -- match new cursors within visual selections by regex.
            set("v", "M", mc.matchCursors)

            -- Rotate visual selection contents.
            set("v", "<leader>t",
                function() mc.transposeCursors(1) end)
            set("v", "<leader>T",
                function() mc.transposeCursors(-1) end)

            -- Jumplist support
            set({ "v", "n" }, "<c-i>", mc.jumpForward)
            set({ "v", "n" }, "<c-o>", mc.jumpBackward)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { link = "Cursor" })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        end
    },
    { -- Hop to other places on the screen
        'smoka7/hop.nvim',
        cmd = "HopWord",
        keys = {
            { '<M-h>', ':HopWord<CR>', desc = "Hop Word" }
        },
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        }
    },
    { -- Perform vim motions on objects elsewhere on the screen
        'Weissle/easy-action',
        opts = {
            jump_provider_config = {
                hop = {
                    action_select = {
                        line = {
                            cmd = "HopLineStartMW",
                        },
                        default = {
                            cmd = "HopChar1",
                        }
                    },
                },
            },
        },
        dependencies = {
            {
                "hop.nvim",
                "kevinhwang91/promise-async",
                module = { "async" },
            }
        },
        keys = {
            {
                "<leader>a",
                "<cmd>BasicEasyAction<cr>",
                desc = "Action Anywhere",
                silent = true,
                remap = false
            },
            {
                "<leader>e",
                function()
                    require("easy-action").base_easy_action("i", nil, "InsertLeave")
                end,
                desc = "Jump edit anywhere",
                silent = true,
                remap = false
            }
        }
    },
}
