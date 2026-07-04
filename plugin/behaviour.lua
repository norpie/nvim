require('lib.packages').add({
    'wellle/targets.vim',
    'McAuleyPenney/tidy.nvim',
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'jghauser/mkdir.nvim',
    'chrishrb/gx.nvim',
    'nemanjamalesija/smart-paste.nvim'
})

local env = require('lib.env')

local things_to_setup = {
    'tidy',
    'nvim-autopairs',
    'nvim-ts-autotag',
    'gx',
    'smart-paste'
}

for _, thing in ipairs(things_to_setup) do
    local ok, plugin = pcall(require, thing)
    local opts = {}
    -- optionally has a file in lua/plugins/behaviour/thing.lua that should have the opts() passed to setup()
    if vim.fn.filereadable(env.config_dir() .. '/lua/plugins/behaviour/' .. thing .. '.lua') == 1 then
        opts = require('plugins.behaviour.' .. thing).opts()
    end
    if not ok then
        vim.notify('Failed to load ' .. thing, vim.log.levels.ERROR)
    else
        if plugin.setup then
            plugin.setup(opts)
        end
    end
end
