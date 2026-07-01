require('lib.packages').add('jdrupal-dev/css-vars.nvim')

local M = {}

function M.providers()
    return {
        css_vars = {
        name = "css-vars",
        module = "css-vars.blink",
        opts = {
          search_extensions = { ".js", ".ts", ".jsx", ".tsx" }
        }
      }
    }
end

return M
