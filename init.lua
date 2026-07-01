-- norpie's neovim configuration

local T = require("lib")

vim.loader.enable()

-- Set our location
local src = debug.getinfo(1, "S").source
local path = src:sub(1, 1) == "@" and src:sub(2) or nil
vim.g.init_lua_path = path and vim.fs.normalize(vim.uv.fs_realpath(path) or path)
