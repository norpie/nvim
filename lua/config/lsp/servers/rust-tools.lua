local rt = require("rust-tools")
rt.setup({
    server = {
        cmd = { "ra-multiplex" },
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>q", rt.code_action_group.code_action_group, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>t", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>p", rt.parent_module.parent_module, { buffer = bufnr })
        end,
    },
})
rt.inlay_hints.disable()
