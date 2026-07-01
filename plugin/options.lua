local set = vim.opt
local g = vim.g
local o = vim.o
local wo = vim.wo

-- files
set.encoding = "utf8"
set.undodir = os.getenv("HOME") .. '/.cache/nvim/undodir'
set.confirm = true
set.undofile = true
set.backup = false
set.swapfile = false

-- behaviour
set.updatetime = 300

-- terminal
set.errorbells = false
set.termguicolors = true

-- view
set.scrolloff = 50
set.wrap = false
set.cursorline = true
wo.fillchars = "eob: "

-- buffers
set.hidden = true

-- mouse
set.mouse = "a"

--split
set.splitright = true
set.splitbelow = true
set.splitkeep = "screen"

-- col
set.relativenumber = true
set.signcolumn = "number"
set.numberwidth = 3

-- search
set.hlsearch = true
set.smartcase = true
set.ignorecase = true
set.incsearch = true

-- edit
set.backspace = "indent,eol,start"
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.smartindent = true

-- leaders
g.mapleader = " "

-- commands
o.cmdheight = 0

-- lang
set.spelllang = "en_uk,fr,fi,nl"
