local M = {}

function M.setup()
    require('indent_blankline').setup()
    require('colorizer').setup()
    require('todo-comments').setup()
    require('numb').setup()
    --require("tint").setup({})
    require('scrollbar').setup()
    require('noice').setup()
    require('project_nvim').setup()
    require('nvim-tree').setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true
        },
    })
end

return M
