local custom_events = vim.api.nvim_create_augroup('CustomEvents', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
    group = custom_events,
    desc = "Trigger DirEnter event when opening a directory",
    callback = function()
        local res = vim.fn.isdirectory(vim.fn.expand('%:p'))
        if res == 1 then
            vim.api.nvim_exec_autocmds("User", {
                pattern = "DirEnter"
            })
        end
    end,
})


local custom_behaviour_group = vim.api.nvim_create_augroup("CustomBehaviour", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = custom_behaviour_group,
    pattern = "*",
    desc = "Restore cursor position when reopening a file",
    command = 'silent! normal! g`"zv',
})

vim.api.nvim_create_autocmd('VimEnter', {
    group = custom_behaviour_group,
    desc = "Project root cd'er",
    callback = function()
        local project_subroot = require('lib.env').project_sub_root()
        if project_subroot ~= "" then
            vim.cmd('cd ' .. project_subroot)
        end
    end,
})

vim.api.nvim_create_autocmd("BufHidden", {
    group = custom_behaviour_group,
    desc = "Delete [No Name] buffers",
    callback = function(event)
        if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
            vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
        end
    end,
})
