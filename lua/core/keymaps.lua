local map = require('util').map

-- dont move over when j- and k-ing
map('', 'j', 'gj')
map('', 'k', 'gk')

-- Disable the execute mode thingy
map('', 'Q', 'q')

-- Create undo points at the symbols
map('i', ',', ',<C-g>u', { noremap = true })
map('i', '.', '.<C-g>u', { noremap = true })
map('i', '!', '!<C-g>u', { noremap = true })
map('i', '?', '?<C-g>u', { noremap = true })
map('i', ':', ':<C-g>u', { noremap = true })
map('i', ';', ';<C-g>u', { noremap = true })

map('n', 'H', '^')
map('n', 'L', '$')

-- Leave unnamed alone when pasting over something
vim.keymap.set("x", "p", function()
    return 'pgv"' .. vim.v.register .. "y"
end, {
    noremap = true,
    expr = true
})

-- Leave unnamed alone when changing
map('n', 'c', '"ac', { noremap = true })
map('n', 'C', '"aC', { noremap = true })

-- Autocorrect from end of word?
map('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true }) -- Spelling

-- Save all buffers and close all except current
map('n', '<C-s>', ':wa<CR>:%bd|e#<CR>')

-- change wins easier
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Resize wins
map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- change buffers
map('n', 'gt', ':bnext<CR>')
map('n', 'gT', ':bprev<CR>')

-- splitting
map('n', '<Leader>sh', ':split<CR>')
map('n', '<Leader>sv', ':vsplit<CR>')

-- Ctrl-backspace deletes words bakwards in insert
map('i', '^?', '<Esc>cvb', { noremap = true })

-- Y should yank the rest of the line not entire liune
map('n', 'Y', 'y$')

-- Cursor doesn't jump to start of selection
map('v', 'y', 'ygv<ESC>')

-- Ctrl-c is clipboard yank
map('v', '<C-C>', '"+y')

-- Ctrl-Shift-V is paste from clipboard
map('i', '<C-V>', '<Esc>"+pa')

-- Open some plugin ui's
map('n', '<Leader>os', ':SymbolsOutline<CR>')
map('n', '<Leader>oa', ':AerialToggle!<CR>')
map('n', '<Leader>gb', ':Flogsplit<CR>')
map('n', '<Leader>gm', ':GitMessenger<CR>')
map('n', '<Leader>n', ':Navbuddy<CR>')

-- Enter zen
map('n', '<Leader>z', ':ZenMode<CR>', { silent = true })

-- Lsp keys
map('n', '<Leader>d', ':lua vim.lsp.buf.definition()<CR>')
map('n', '<Leader>p', ':lua vim.lsp.buf.type_definition()<CR>')
map('n', '<Leader>h', ':lua vim.lsp.buf.hover()<CR>')
map('n', '<Leader>f', ':lua vim.lsp.buf.format()<CR>')
map('n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>')
map('n', '<Leader>q', ':CodeActionMenu<CR>')

-- Trouble keys
map('n', '<Leader>tt', ':TroubleToggle<CR>')
map('n', '<Leader>tq', ':TroubleToggle quickfix<CR>')
map('n', '<Leader>tw', ':TroubleToggle workspace_diagnostics<CR>')
map('n', '<Leader>td', ':TroubleToggle document_diagnostics<CR>')

-- Snippets
map('n', '<Leader>se', ':edit! ~/.config/nvim/lua/config/luasnip.lua<CR>')
vim.cmd [[
    " Use Tab to expand and jump through snippets
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

    " Use Shift-Tab to jump backwards through snippets
    imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

-- git -> Git
vim.cmd('cnoreabbrev Git git')

-- :Write to not care about permissions
vim.cmd('cnoreabbrev Write w !sudo tee %')

-- dont care for fat fingering :W instead of :w
vim.cmd('cnoreabbrev W w')
