require('lib.packages').add('erooke/blink-cmp-latex')

local M = {}

function M.providers()
    return { -- TODO: re-enable when blink v2 is stable and plugin is updated
		--         latex = {
		-- 	name = "Latex",
		-- 	module = "blink-cmp-latex",
		-- 	opts = {
		-- 		-- set to true to insert the latex command instead of the symbol
		-- 		insert_command = false
		-- 	},
		-- },
    }
end

return M
