local M = {}

local env_files = {
    ".nvim.env",
    ".env"
}

local is_loaded = false

-- Evaluate the environment files and load them into the current environment
M.load = function()
    if is_loaded then
        return
    end
    for _, file in ipairs(env_files) do
    end
    is_loaded = true
end

return M
