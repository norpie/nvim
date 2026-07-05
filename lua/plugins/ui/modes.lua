local M = {}

function M.opts()
    return {
        colors = {
            bg = "", -- Optional bg param, defaults to Normal hl group
            copy = "#f5c359",
            delete = "#c75c6a",
            change = "#f3f99d",
            format = "#c79585",
            insert = "#78ccc5",
            replace = "#245361",
            felect = "#9745be", -- Optional param, defaults to visual
            visual = "#9745be",
        },
        line_opacity = 0.15,
        -- Enable cursor highlights
        set_cursor = true,
        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,
        -- Enable line number highlights to match cursorline
        set_number = false,
        -- Enable sign column highlights to match cursorline
        set_signcolumn = false,
    }
end

function M.post()
    vim.o.cmdheight = 0
end

return M
