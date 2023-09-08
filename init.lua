vim.loader.enable()

local core_modules = {
    "core.options",
    "core.autocmd",
    "core.keymaps",
}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify("Error loading " .. module .. "\n\n" .. err)
    end
end

if vim.fn.filereadable(vim.fn.stdpath "config" .. "/lua/manager.lua") == 1 then
    local ok, err = pcall(require, "manager")
    if not ok then
        vim.notify("Error loading package manager\n\n" .. err)
    end
end
