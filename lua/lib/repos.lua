local M = {}

function M.gh(slug)
    return 'https://github.com/' .. slug
end

function M.gl(slug)
    return 'https://gitlab.com/' .. slug
end

return M
