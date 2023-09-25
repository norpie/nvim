local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local custom_events = 'customeventsgroup'
create_augroup(custom_events, { clear = true })
create_autocmd('VimEnter', {
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


local java_group = 'javagroup'
create_augroup(java_group, { clear = true })
create_autocmd('BufReadPost', {
    pattern = "*.java",
    callback = function()
        require('lsp.jdtls').launch()
    end,
    group = java_group
})

local misc_events = 'miscgroup'
create_augroup(misc_events, { clear = true })
create_autocmd("BufHidden", {
    desc = "Delete [No Name] buffers",
    callback = function(event)
        if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
            vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
        end
    end,
    group = misc_events
})

local save_file_group = 'writegroup'
create_augroup(save_file_group, { clear = true })
create_autocmd('BufWritePost', { pattern = '*.lua', command = 'source %', group = save_file_group })
create_autocmd('BufWritePre', { pattern = '*', command = 'retab!', group = save_file_group })
create_autocmd('BufWritePost',
    {
        pattern = 'Xresources',
        command = 'silent !xrdb -merge ~/.config/X11/Xresources && notify-send "Xresources saved\\! 💾"',
        group = save_file_group
    })
create_autocmd('BufWritePost',
    {
        pattern = 'dunstrc',
        command = 'silent !restart dunst && notify-send "dunstrc saved\\! 💾"',
        group = save_file_group
    })

local syntax_group = 'syntaxgroup'
create_augroup(syntax_group, { clear = true })
create_autocmd('BufNewFile', { pattern = '*.md', command = 'set filetype=markdown.pandoc', group = syntax_group })
create_autocmd('BufFilePre', { pattern = '*.md', command = 'set filetype=markdown.pandoc', group = syntax_group })
create_autocmd('BufRead', { pattern = '*.md', command = 'set filetype=markdown.pandoc', group = syntax_group })

create_autocmd('BufNewFile', { pattern = '*.tera', command = 'set filetype=htmldjango', group = syntax_group })
create_autocmd('BufFilePre', { pattern = '*.tera', command = 'set filetype=htmldjango', group = syntax_group })
create_autocmd('BufRead', { pattern = '*.tera', command = 'set filetype=htmldjango', group = syntax_group })
