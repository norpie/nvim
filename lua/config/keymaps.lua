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

local function map(mode, lhs, rhs, opts)
    local options = {
        silent = true
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- dont move over when j- and k-ing with :set wrap
map('', 'j', 'gj')
map('', 'k', 'gk')

map({ 'n', 'v' }, '<Space>', '<Nop>')

-- Disable the execute mode thingy
map('', 'Q', 'q')

-- Create undo points at the symbols
noremap('i', ',', ',<C-g>u')
noremap('i', '.', '.<C-g>u')
noremap('i', '!', '!<C-g>u')
noremap('i', '?', '?<C-g>u')
noremap('i', ':', ':<C-g>u')
noremap('i', ';', ';<C-g>u')

-- Get to relevant beginning and end
map('n', 'H', '^')
map('n', 'L', '$')

-- Leave unnamed alone when pasting over something
noremap("x", "p", function() return 'pgv"' .. vim.v.register .. "y" end, { expr = true })

-- Leave unnamed alone when changing
noremap('n', 'c', '"ac')
noremap('n', 'C', '"aC')

-- Autocorrect from end of word?
noremap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u') -- Spelling

-- Save all buffers and close all except current
map('n', '<C-s>', ':wa<CR>:%bdelete|e#<CR>')

local function move_or_create_win(key)
    local fn = vim.fn
    local curr_win = fn.winnr()
    vim.cmd("wincmd " .. key)        --> attempt to move

    if (curr_win == fn.winnr()) then --> didn't move, so create a split
        if key == "h" or key == "l" then
            vim.cmd("wincmd v")
        else
            vim.cmd("wincmd s")
        end

        vim.cmd("wincmd " .. key)
    end
end

-- change wins easier
map('n', '<C-h>', function() move_or_create_win('h') end)
map('n', '<C-j>', function() move_or_create_win('j') end)
map('n', '<C-k>', function() move_or_create_win('k') end)
map('n', '<C-l>', function() move_or_create_win('l') end)

local function close_or_delete()
    local bufnr = vim.fn.bufnr()
    local count = 0
    for _, b in ipairs(vim.fn.tabpagebuflist()) do
        if bufnr == b then
            count = count + 1
        end
    end
    if count > 1 then
        vim.cmd("close")
    else
        vim.cmd("bdelete")
    end
end

map('n', ';bd', function() close_or_delete() end)

-- Resize wins
map('n', '<C-s-h>', ':resize +2<CR>')
map('n', '<C-s-j>', ':resize -2<CR>')
map('n', '<C-s-k>', ':vertical resize -2<CR>')
map('n', '<C-s-l>', ':vertical resize +2<CR>')

-- change buffers
-- map('n', '<tab>', ':bnext<CR>')
-- map('n', '<s-tab>', ':bprev<CR>')

map('n', "<leader>Ls", "<cmd>Lazy sync<cr>")
map('n', "<leader>Lc", "<cmd>Lazy clean<cr>")
map('n', "<leader>Lu", "<cmd>Lazy check<cr>")
map('n', "<leader>Li", "<cmd>Lazy install<cr>")
map('n', "<leader>Lh", "<cmd>Lazy home<cr>")


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

vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[ca Write w !sudo tee %]])
vim.cmd([[ca W w]])
