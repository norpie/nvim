require('lib.packages').add({
    'esmuellert/codediff.nvim'
})

local env = require('lib.env')

local things_to_setup = {
    'codediff'
}

for _, thing in ipairs(things_to_setup) do
    local ok, plugin = pcall(require, thing)
    local opts = {}
    if vim.fn.filereadable(env.config_dir() .. '/lua/plugins/addons/' .. thing .. '.lua') == 1 then
        opts = require('plugins.addons.' .. thing).opts()
    end
    if not ok then
        vim.notify('Failed to load ' .. thing, vim.log.levels.ERROR)
    else
        if plugin.setup then
            plugin.setup(opts)
        end
    end
end
