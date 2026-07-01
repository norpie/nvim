local packages = require("lib.packages")

packages.add { { "catppuccin/nvim", name = "catppuccin" } }

vim.cmd.colorscheme "catppuccin-mocha"
