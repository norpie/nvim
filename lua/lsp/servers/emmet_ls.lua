-- Emmet language server configuration
return {
    cmd = { 'emmet-ls', '--stdio' },
    filetypes = { "html", "css", "scss", "less", "php", "javascriptreact", "typescriptreact" },
    root_markers = { '.git' },
}
