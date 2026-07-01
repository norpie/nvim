require('lib.packages').add('Kaiser-Yang/blink-cmp-dictionary')

local M = {}

function M.providers()
    local env = require('lib.env')
    return { 
        dictionary = {
            module = 'blink-cmp-dictionary',
            name = 'Dict',
            min_keyword_length = 1,
            opts = {
                force_fallback = true,
                dictionary_files = {
                    env.config_dir() .. '/words.txt'
                }
            }
        }
    }
end

return M
