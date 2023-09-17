return {
    {
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>me', function() require("nabla").enable_virt() end },
            { '<leader>md', function() require("nabla").disable_virt() end },
            { '<leader>mh', function() require("nabla").popup() end }
        }
    },
    --{
    --    -- 'norpie-dev/quotes.nvim' -- TODO: make plugin
    --}
}
