local non_insert_modes = { 'n', 'v', 'x', 'o' }

local function map(mode, lhs, rhs, opts)
    local options = {
        silent = true
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local function noremap(mode, lhs, rhs, opts)
    local options = {
        noremap = true,
        silent = true
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local keymap_non_insert = function(lhs, rhs)
    vim.keymap.set(non_insert_modes, lhs, rhs, { noremap = true, silent = true })
end

local no_wait = function(lhs, rhs)
    vim.keymap.set(non_insert_modes, lhs, rhs, { noremap = true, silent = false, nowait = true })
end

-- disable space
map({ 'n', 'v' }, '<space>', '<nop>')
-- replace execute mode with macro
map('', 'Q', 'q')

noremap('i', ',', ',<C-g>u')
noremap('i', '.', '.<C-g>u')
noremap('i', '!', '!<C-g>u')
noremap('i', '?', '?<C-g>u')
noremap('i', ':', ':<C-g>u')
noremap('i', ';', ';<C-g>u')

-- homerow motions, used for all other mappings too
keymap_non_insert('j', 'h')
keymap_non_insert('k', 'gj')
keymap_non_insert('l', 'gk')
keymap_non_insert(';', 'l')

-- inline motions
keymap_non_insert('J', '^')
keymap_non_insert(':', '$')

-- file x & line x
keymap_non_insert('G', "G$")
keymap_non_insert('gg', 'gg^')

-- buffers
keymap_non_insert('<tab>', '<cmd>bnext<cr>')
keymap_non_insert('<s-tab>', '<cmd>bprevious<cr>')

-- delete buffer, prioritize deleting split first
keymap_non_insert('<leader>bd', function()
    if vim.fn.winnr('$') > 1 then
        vim.cmd('close')
    else
        vim.cmd('bdelete')
    end
end)

local dir = {
    j = "h",     -- homerow j -> left
    k = "j",     -- homerow k -> down
    l = "k",     -- homerow l -> up
    [";"] = "l", -- homerow ; -> right
}

local split_for_dir = {
    h = "leftabove vsplit",
    l = "rightbelow vsplit",
    k = "leftabove split",
    j = "rightbelow split",
}

local function move_or_create_win(key)
    local target = dir[key] or key
    local curr = vim.api.nvim_get_current_win()

    vim.cmd("wincmd " .. target)

    if vim.api.nvim_get_current_win() == curr then
        vim.cmd(split_for_dir[target])
    end
end

keymap_non_insert('<c-j>', function() move_or_create_win('j') end)
keymap_non_insert('<c-k>', function() move_or_create_win('k') end)
keymap_non_insert('<c-l>', function() move_or_create_win('l') end)
keymap_non_insert('<M-[>9;8~', function() move_or_create_win(';') end)

-- weird helpers
-- Leave unnamed alone when pasting over something
noremap("x", "p", function() return 'pgv"' .. vim.v.register .. "y" end, { expr = true })

-- Leave unnamed alone when changing
noremap('n', 'c', '"ac')
noremap('n', 'C', '"aC')

-- Autocorrect from end of word?
noremap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u') -- Spelling

-- Save all buffers and close all except current
map('n', '<C-s>', ':wa<CR>:%bdelete|e#<CR>')

-- Ctrl-backspace deletes words bakwards in insert
noremap('i', '<C-H>', '<Esc>cvb')

-- Calc in insert mode
map('i', '<C-=>', '<C-r>=')

-- Y should yank the rest of the line not entire liune
map('n', 'Y', 'y$')

-- Cursor doesn't jump to start of selection
map('v', 'y', 'ygv<ESC>')

-- Ctrl-c is clipboard yank, Ctrl-Shift-V is paste from clipboard
map('v', '<C-c>', '"+y')
map('i', '<C-s-v>', '<Esc>"+pa')

-- command line
no_wait(',', ':')
