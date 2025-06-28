local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local create_autocmds = function(events, opts)
    if type(events) == 'string' then
        events = { events }
    end
    for _, event in ipairs(events) do
        create_autocmd(event, opts)
    end
end

local custom_events = 'customeventsgroup'
create_augroup(custom_events, { clear = true })
create_autocmd('VimEnter', { -- Fire custom "DirEnter" event when opening a directory
    callback = function()
        local res = vim.fn.isdirectory(vim.fn.expand('%:p'))
        if res == 1 then
            vim.api.nvim_exec_autocmds("User", {
                pattern = "DirEnter"
            })
        end
    end,
    group = custom_events
})

create_autocmd('BufWinEnter', { -- Set the cursor to the last position when opening a file
    desc = 'return cursor to where it was last time closing the file',
    pattern = '*',
    command = 'silent! normal! g`"zv',
    group = custom_events
})

local misc_events = 'miscgroup'
create_augroup(misc_events, { clear = true })
create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
    end,
    group = misc_events,
})
create_autocmd("BufHidden", { -- Close the buffer if it's hidden
    desc = "Delete [No Name] buffers",
    callback = function(event)
        if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
            vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
        end
    end,
    group = misc_events
})
create_autocmd('VimEnter', { -- If `$(git dir)` exits with `$? -eq 0`, `cd $(git root)`
    desc = "Project root cd'er",
    callback = function()
        local git_dir = vim.fn.system('project subroot')
        if git_dir ~= "" then
            vim.cmd('cd ' .. git_dir)
        end
    end,
    group = misc_events,
})
create_autocmd('BufReadPost', { -- Set the filetype to surql for .surql files
    desc = "Set filetype based on file extension",
    pattern = '*.surql',
    command = 'set filetype=surql',
    group = misc_events
})
create_autocmds({ 'FocusGained', 'BufEnter' }, { -- Load the file on focus gained or buffer enter
    desc = "Load the file on focus gained or buffer enter",
    pattern = '*',
    -- command = 'silent! e',
    callback = function()
        vim.cmd('silent! e')
        -- vim.notify('File reloaded', vim.log.levels.INFO)
    end,
    group = misc_events
})
create_autocmds({ 'FocusLost', 'WinLeave' }, { -- Save the file on focus lost or window leave
    desc = "Save the file on focus lost or window leave",
    pattern = '*',
    -- command = 'silent! w',
    callback = function()
        vim.cmd('silent! w')
        -- vim.notify('File saved', vim.log.levels.INFO)
    end,
    group = misc_events
})
