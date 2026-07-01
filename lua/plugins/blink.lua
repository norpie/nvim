packages = require("lib.packages")

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

-- if nvim config enable lazydev
if nvim.is_nvim_config() then
    local lazydev = require('plugins.lazydev')
    sources = merge_sources_and_providers(sources, lazydev.sources(), lazydev.providers())
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
