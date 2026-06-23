local opts = { noremap = true, silent = true }

-- Telescope
vim.keymap.set('n', '<leader>ff', '<CMD>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fb', '<CMD>Telescope file_browser<CR>', opts)
vim.keymap.set('n', '<leader>fg', '<CMD>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<leader>bu', '<CMD>Telescope buffers<CR>', opts)
