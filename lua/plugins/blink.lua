local env = require("lib.env")

require("lib.packages").add({
    'saghen/blink.lib',
    'saghen/blink.cmp',
    -- snippets
    'rafamadriz/friendly-snippets',
    'xzbdmw/colorful-menu.nvim',
})

local cmp = require('blink.cmp')
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

    completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        menu = {
            draw = {
                -- We don't need label_description now because label and label_description are already
                -- combined together in label by colorful-menu.nvim.
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                },
            },
            direction_priority = function()
                local ctx = require('blink.cmp').get_context()
                local item = require('blink.cmp').get_selected_item()
                if ctx == nil or item == nil then return { 's', 'n' } end

                local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
                local is_multi_line = item_text:find('\n') ~= nil

                -- after showing the menu upwards, we want to maintain that direction
                -- until we re-open the menu, so store the context id in a global variable
                if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
                    vim.g.blink_cmp_upwards_ctx_id = ctx.id
                    return { 'n', 's' }
                end
                return { 's', 'n' }
            end,
        },
    },

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
