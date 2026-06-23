local neotest = require('neotest')

neotest.setup({
    adapters = {
        require('neotest-golang'),
        require('neotest-python'),
    },
})

-- Keymaps — <leader>t*
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>tn', function() neotest.run.run() end, opts)
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, opts)
vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, opts)
vim.keymap.set('n', '<leader>to', function() neotest.output.open({ enter = true }) end, opts)
