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

local function merge_sources_and_providers(old_sources, new_sources, new_providers)
    for _, source in ipairs(new_sources) do
        table.insert(old_sources.default, source)
    end
    for name, provider in pairs(new_providers) do
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
    if module.should_enable() then
        sources = merge_sources_and_providers(sources, module.sources(), module.providers())
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
