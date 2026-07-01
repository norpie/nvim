require('lib.packages').add('bydlw98/blink-cmp-sshconfig')

local M = {}

function M.providers()
    return {
        sshconfig = {
            name = "SshConfig",
            module = "blink-cmp-sshconfig",
            --- @module 'blink-cmp-sshconfig'
            --- @type blink-cmp-sshconfig.Options
            opts = {
                prefer_pre_generated = true,
            },
        }
    }
end

return M
