return {
    "m4xshen/smartcolumn.nvim",
    config = function()
        require("smartcolumn").setup({
            colorcolumn = "100",
            disabled_filetypes = { "help", "text", "markdown", "lazy" },
            custom_colorcolumn = {},
            scope = "window",
        })
    end,
    event = 'VeryLazy',
    opts = {}
}
