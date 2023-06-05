return {
    'phaazon/hop.nvim',
    branch = 'v2',
    lazy = false,
    init = function()
        --local hop = require('hop')
        --hop.setup()
        --local directions = require('hop.hint').HintDirection
        vim.keymap.set('n', '<leader>H', ':HopWord<CR>')
        --vim.keymap.set('n', 'f', function()
        --    hop.hint_char1({
        --        direction = directions.AFTER_CURSOR,
        --        current_line_only = true
        --    })
        --end, { noremap = true })
        --vim.keymap.set('n', 'F', function()
        --    hop.hint_char1({
        --        direction = directions.BEFORE_CURSOR,
        --        current_line_only = true
        --    })
        --end, { noremap = true })
        --vim.keymap.set('n', 't', function()
        --    hop.hint_char1({
        --        direction = directions.AFTER_CURSOR,
        --        current_line_only = true,
        --        hint_offset = -1
        --    })
        --end, { noremap = true })
        --vim.keymap.set('n', 'T', function()
        --    hop.hint_char1({
        --        direction = directions.BEFORE_CURSOR,
        --        current_line_only = true,
        --        hint_offset = 1
        --    })
        --end, { noremap = true })
    end
}
