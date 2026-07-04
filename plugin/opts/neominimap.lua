vim.g.neominimap = {
    auto_enable = true,
    click = {
        enabled = true,
    },
    diagnostic = {
        severity = vim.diagnostic.severity.ERROR,
    },
    buf_filter = function(bufnr)
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        return line_count < 4096
    end,
}
