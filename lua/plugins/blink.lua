packages = require("lib.packages")
env = require("lib.env")

packages.add({ 
    'saghen/blink.lib',
    'saghen/blink.cmp',
    -- snippets
    'rafamadriz/friendly-snippets',
})

local cmp = require('blink.cmp')
local nvim = require('lib.nvim')
cmp.build():pwait()

local sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' },
    providers = {}
}

local function merge_sources_and_providers(old_sources, new_providers)
    for name, provider in pairs(new_providers) do
        table.insert(old_sources.default, name)
        old_sources.providers[name] = provider
    end
    return old_sources
end

local modules_path = env.config_dir() .. "/lua/plugins/blink-modules"
for _, module_file in ipairs(vim.fn.readdir(modules_path, [[v:val =~ '\.lua$']])) do
    local module_path = env.relative_lua_path(modules_path .. "/" .. module_file)
    local ok, module = pcall(require, module_path:gsub("%.lua$", ""))
    if not ok then
        print("Failed to load module: " .. module_file .. "\n" .. module)
    end
    -- should enable is optional, if not present, the module will be enabled by default
    local ok, should_enable = pcall(module.should_enable)
    if not ok then
        should_enable = true
    end
    if should_enable then
        sources = merge_sources_and_providers(sources, module.providers() or {})
    end
end

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
    keymap = { preset = 'super-tab' },

    completion = { documentation = { auto_show = true } },

    sources = sources,

    cmdline = {
        completion = {
            menu = {
                auto_show = true
            }
        },
    },

    signature = { enabled = true },

    fuzzy = { implementation = "rust" }
}

cmp.setup(opts)
