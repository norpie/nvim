-- TypeScript/JavaScript language support
return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "vuki656/package-info.nvim", opts = {} },
    },
    lazy = true,
    ft = { 'ts', 'tsx', 'js', 'jsx', 'svelte' },
    config = function()
        vim.keymap.set('n', 'gd', '<cmd>TypescriptToolsGoToSourceDefinition<CR>', { desc = 'Go to source definition' })
    end,
    opts = {}
}
