return {
    {
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>me', function() require("nabla").enable_virt() end, desc = 'Enable scientific math' },
            { '<leader>md', function() require("nabla").disable_virt() end, desc = 'Disable scientific math' },
            { '<leader>mh', function() require("nabla").popup() end, desc = "Popup scientific math" },
        }
    },
    --{
    --    -- 'norpie-dev/quotes.nvim' -- TODO: make plugin
    --}
}
