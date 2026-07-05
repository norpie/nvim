require('lib.packages').add({
    'j-hui/fidget.nvim',
    'lewis6991/gitsigns.nvim',
    'jinh0/eyeliner.nvim',
    "leath-dub/snipe.nvim",
    'mawkler/modicator.nvim',
    'saghen/blink.indent',
    'FylerOrg/fyler.nvim',
    'Bekaboo/dropbar.nvim',
    'lewis6991/satellite.nvim',
    'Isrothy/neominimap.nvim',
    'RRethy/vim-illuminate',
    'hiphish/rainbow-delimiters.nvim',
    'mvllow/modes.nvim'
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
    'neominimap',
    'rainbow-delimiters.setup',
    'modes'
}

for _, thing in ipairs(things_to_setup) do
    local ok, plugin = pcall(require, thing)
    local pre, post = nil, nil
    local opts = {}
    -- subtract .* from the end of the string if it exists, e.g. rainbow-delimiters.setup -> rainbow-delimiters
    local probable_opts_file = thing:gsub('%.setup$', '')
    -- optionally has a file in lua/plugins/ui/thing.lua that should have the opts() passed to setup()
    if vim.fn.filereadable(env.config_dir() .. '/lua/plugins/ui/' .. probable_opts_file .. '.lua') == 1 then
        local ok2, config = pcall(require, 'plugins.ui.' .. probable_opts_file)
        if ok2 then
            if config.opts then
                opts = config.opts()
            end
            if config.pre then
                pre = config.pre
            end
            if config.post then
                post = config.post
            end
        end
    end
    if not ok then
        vim.notify('Failed to load ' .. probable_opts_file, vim.log.levels.ERROR)
    else
        if pre then
            pre()
        end
        if plugin.setup then
            plugin.setup(opts)
        end
        if post then
            post()
        end
    end
end
