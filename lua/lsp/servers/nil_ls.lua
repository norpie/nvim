-- nil_ls.lua: *.nix
local M = {}

function M.settings()
    return {
        ['nil'] = {
            formatting = {
                command = {
                    "alejandra",
                }
            }
        },
    }
end

function M.filetypes()
    local filetypes = {
        'nix',
    }
    return filetypes
end

function M.cmd()
    return {
        'nil'
    }
end

return M
