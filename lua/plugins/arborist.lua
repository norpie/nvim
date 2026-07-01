local packages = require("lib.packages")

packages.add({
    'arborist-ts/arborist.nvim'
})

require("arborist").setup()
