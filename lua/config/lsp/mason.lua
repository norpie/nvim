local M = {}

function M.setup()
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    })
    require("mason-lspconfig").setup()
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("mason-lspconfig", { clear = true }),
        callback = function(t)
            if vim.bo[t.buf].buftype ~= "" then return end
            local mason_lspconfig = require("mason-lspconfig")
            local available_servers =
                mason_lspconfig.get_available_servers({ filetype = t.match })
            local installed_servers = mason_lspconfig.get_installed_servers()
            local is_available = false
            for _, available in ipairs(available_servers) do
                for _, installed in ipairs(installed_servers) do
                    if available == installed then return end
                end
                is_available = true
            end
            if is_available then
                vim.schedule(vim.cmd.LspInstall)
            end
        end,
    })
end

return M
