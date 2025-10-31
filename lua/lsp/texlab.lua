-- LaTeX language server configuration
return {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'bib' },
    root_markers = { '.latexmkrc', '.git' },
}
