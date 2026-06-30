local all_modes = {'n', 'v', 'x', 'o'}

local keymap_all = function(lhs, rhs)
  vim.keymap.set(all_modes, lhs, rhs, { noremap = true, silent = true })
end

local no_wait = function(lhs, rhs)
  vim.keymap.set(all_modes, lhs, rhs, { noremap = true, silent = false, nowait = true })
end

-- homerow motions
keymap_all('j', 'h')
keymap_all('k', 'gj')
keymap_all('l', 'gk')
keymap_all(';', 'l')

-- inline motions
keymap_all('J', '^')
keymap_all(':', '$')

-- file x & line x
keymap_all('G', "G$")
keymap_all('gg', 'gg^')

-- command line
no_wait(',', ':')
