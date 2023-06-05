return {
    "m4xshen/smartcolumn.nvim",
    lazy = false,
    init = function()
        require("smartcolumn").setup({
            colorcolumn = "100",
            disabled_filetypes = { "help", "text", "markdown", "lazy" },
            custom_colorcolumn = {},
            scope = "window",
        })
    end,
    opts = {}
}
