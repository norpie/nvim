local M = {}

local env_files = {
    ".nvim.env",
    ".env"
}

local is_loaded = false

-- Evaluate the environment files and load them into the current environment
-- TODO: Actually evaluate the files and load them into the environment
M.load = function()
    if is_loaded then
        return
    end
    for _, file in ipairs(env_files) do
    end
    is_loaded = true
end

M.config_dir = function()
    local init_path = vim.g.init_lua_path
    return vim.fn.fnamemodify(init_path, ":h")
end

-- Subtract the config directory from the given path and return a relative path, e.g. "/home/user/.config/nvim/lua/plugins/blink.lua" -> "lua/plugins/blink.lua"
M.relative_path = function(path)
    local config_dir = M.config_dir()
    return vim.fn.fnamemodify(path, ":~:.")
end

-- Subtract the config directory and the "lua" directory from the given path and return a relative path, e.g. "/home/user/.config/nvim/lua/plugins/blink.lua" -> "plugins/blink.lua"
M.relative_lua_path = function(path)
    local config_dir = M.config_dir()
    local lua_dir = config_dir .. "/lua"
    return vim.fn.fnamemodify(path, ":~:."):gsub("^lua/", "")
end

return M
