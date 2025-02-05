vim.loader.enable()

local core_modules = {
    "config.options",
    "config.autocmds",
    "config.keymaps",
    "config.lazy"
}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify("Error loading " .. module .. "\n\n" .. err)
    end
end
