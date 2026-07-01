local M = {}

local default_spec = {
    branch = 'main',
    platform = 'github',
}

local default_opts = {
    confirm = false,
}

-- end form should always be a list of tables, even if it's just one table, even when coming from a mix of strings and tables, so we normalize the input to always be a list of tables
local function normalize_specs(spec)
    if type(spec) == 'string' then
        return { { spec } }
    elseif type(spec) == 'table' then
        if #spec == 0 then
            return { spec }
        else
            local normalized = {}
            for _, s in ipairs(spec) do
                if type(s) == 'string' then
                    table.insert(normalized, { s })
                elseif type(s) == 'table' then
                    table.insert(normalized, s)
                end
            end
            return normalized
        end
    else
        error('Invalid spec type: ' .. type(spec))
    end
end

local plugins_with_build = {}

-- use vim.pack.add to add a package to the runtime path
-- using custom repository helper
function M.add(specs)
    specs = normalize_specs(specs)
    for _, spec in ipairs(specs) do
        local repo = spec[1]
        local build = spec.build
        local platform = spec.platform or default_spec.platform
        local src = 'https://' .. platform .. '.com/' .. repo
        local branch = spec.branch
        local built_spec = {src = src, version = branch}
        for k, v in pairs(spec) do
            if k ~= 1 and k ~= 'branch' and k ~= 'platform' then
                built_spec[k] = v
            end
        end
        vim.pack.add({built_spec}, default_opts)
        if build then
            plugins_with_build[repo] = build
        end
    end
end

local function build_plugin(repo, build)
    -- something like this: nvim/site/pack/core/opt/telescope-fzf-native.nvim
    local repo_name = repo:match('.*/(.*)')
    local plugin_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/' .. repo_name
    if vim.fn.isdirectory(plugin_path) == 1 then
        if type(build) == 'string' then
            local build_cmd = vim.split(build, ' ')
            vim.system(build_cmd, { cwd = plugin_path })
        elseif type(build) == 'function' then
            build()
        end
    end
end

local function hooks()
    for repo, build in pairs(plugins_with_build) do
        build_plugin(repo, build)
    end
end

vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })
vim.api.nvim_create_user_command('PackBuild', function()
    hooks()
end, {})

return M
