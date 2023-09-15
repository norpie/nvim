local set = vim.opt

HOME = os.getenv('HOME')
if (HOME ~= nil) then
    set.undodir = HOME .. '/.cache/nvim/undodir'
end

-- leader
vim.g.mapleader = ' '

set.encoding = 'utf8'

vim.wo.fillchars = 'eob: '

set.relativenumber = true
set.signcolumn = 'number'
set.number = true
set.numberwidth = 2
set.hlsearch = true
set.hidden = true
set.errorbells = false

set.splitright = true
set.splitbelow = true
set.splitkeep = 'screen'

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true

set.mouse = 'a'
set.cursorline = true
set.wrap = false
set.ruler = true
set.foldenable = false

set.ignorecase = true
set.smartcase = true
set.incsearch = true

set.confirm = true
set.swapfile = false
set.backup = false
set.undofile = true

set.termguicolors = true
set.scrolloff = 50
set.updatetime = 4000
set.cmdheight = 1
set.spelllang = 'fi,fr,nl,en'
set.laststatus = 1
set.showmode = false
set.conceallevel = 0
set.showtabline = 0
