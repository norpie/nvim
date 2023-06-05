local set = vim.opt
local g = vim.g

-- leader
vim.g.mapleader = ' '

-- autosave
g.auto_save_silent = 1
g.auto_save = 1

set.encoding = 'utf8'

--set.completeopt = {'menu', 'menuone', 'noselect'}

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

--set.wildmenu = true
--set.wildmode = 'list:full'

HOME = os.getenv('HOME')
if (HOME ~= nil) then
    set.undodir = HOME .. '/.cache/nvim/undodir'
end

set.termguicolors = true
set.scrolloff = 50
set.cmdheight = 1
set.updatetime = 25
set.spelllang = 'fi,fr,nl,en'
set.laststatus = 3
set.showmode = false
set.conceallevel = 0
set.showtabline = 0
