local M = {}

local env_files = {
    ".nvim.env",
    ".env"
}

local is_loaded = false

local function normalize_path(path)
    return vim.fs.normalize(vim.fn.fnamemodify(vim.fn.expand(path), ":p"))
end

local function relative_to(path, root)
    path = normalize_path(path)
    root = normalize_path(root)

    local prefix = root .. "/"
    if path:sub(1, #prefix) == prefix then
        return path:sub(#prefix + 1)
    end

    return path
end

M.config_dir = function()
    local init_path = vim.g.init_lua_path
    return vim.fs.normalize(vim.fn.fnamemodify(init_path, ":h"))
end

-- Subtract the config directory from the given path and return a relative path, e.g. "/home/user/.config/nvim/lua/plugins/blink.lua" -> "lua/plugins/blink.lua"
M.relative_path = function(path)
    return relative_to(path, M.config_dir())
end

-- Subtract the config directory and the "lua" directory from the given path and return a relative path, e.g. "/home/user/.config/nvim/lua/plugins/blink.lua" -> "plugins/blink.lua"
M.relative_lua_path = function(path)
    return relative_to(path, M.config_dir() .. "/lua")
end

-- use `project root` command, spits out an absolute path to the root of the project, useful for projects that have multiple subprojects, e.g. a monorepo
-- warning: only relies on git internally to the command, so if the project is not a git repo, it will return nothing, we fall back to cwd
M.project_root = function()
    local ok, root = pcall(vim.fn.system, "project root")
    if ok then
        return vim.fs.normalize(vim.fn.fnamemodify(root, ":p"))
    else
        return vim.fs.normalize(vim.fn.getcwd())
    end
end

-- use `project subroot` command, spits out an absolute path to the subroot of the project, useful for projects that have multiple subprojects, e.g. a monorepo
-- internally falls back to `project root` if no subroot is found, and then falls back to cwd if no project root is found
M.project_sub_root = function()
    local ok, subroot = pcall(vim.fn.system, "project subroot")
    if ok then
        return vim.fs.normalize(vim.fn.fnamemodify(subroot, ":p"))
    else
        M.project_root()
    end
end

local function load_local_env(file)
    local env_file = io.open(file, "r")
    if not env_file then
        return
    end

    local ok, err = pcall(function()
        for line in env_file:lines() do
            if not line:match("^%s*#") then                                        -- Skip comments
                for key, value in string.gmatch(line, "([%w_]+)%s*=%s*([^#]+)") do -- varname=value
                    value = value:gsub("^%s*(.-)%s*$", "%1")                       -- Trim whitespace
                    vim.fn.setenv(key, value)
                end
            end
        end
    end)

    env_file:close()

    if not ok then
        vim.notify("Error parsing " .. file .. ": " .. tostring(err), vim.log.levels.WARN)
    end
end

M.load = function()
    if is_loaded then
        return
    end
    for _, file in ipairs(env_files) do
        load_local_env(file)
    end
    is_loaded = true
end



return M
