require('lib.packages').add('bydlw98/blink-cmp-env')

local M = {}

function M.providers()
    return {
        env = {
            name = "Env",
            module = "blink-cmp-env",
            --- @type blink-cmp-env.Options
            opts = {
                item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
                show_braces = false,
                show_documentation_window = true,
            },
        }
    }
end

return M
