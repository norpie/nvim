require('lib.packages').add({
    'j-hui/fidget.nvim',
    'lewis6991/gitsigns.nvim',
    'jinh0/eyeliner.nvim',
    "leath-dub/snipe.nvim",
    'mawkler/modicator.nvim',
    'saghen/blink.indent',
    'FylerOrg/fyler.nvim',
    'Bekaboo/dropbar.nvim',
    'lewis6991/satellite.nvim'
})

local env = require('lib.env')

local things_to_setup = {
    'fidget',
    'gitsigns',
    'eyeliner',
    'snipe',
    'modicator',
    'fyler',
    'satellite',
}

for _, thing in ipairs(things_to_setup) do
    local ok, plugin = pcall(require, thing)
    local opts = {}
    -- optionally has a file in lua/plugins/ui/thing.lua that should have the opts() passed to setup()
    if vim.fn.filereadable(env.config_dir() .. '/lua/plugins/ui/' .. thing .. '.lua') == 1 then
        opts = require('plugins.ui.' .. thing).opts()
    end
    if not ok then
        vim.notify('Failed to load ' .. thing, vim.log.levels.ERROR)
    else
        if plugin.setup then
            plugin.setup(opts)
        end
    end
end
