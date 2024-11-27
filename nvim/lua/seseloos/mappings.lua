local noremap = require('seseloos.keymap').noremap
local nnoremap = require('seseloos.keymap').nnoremap

-- telescope quickactions
nnoremap('<leader>ff', '<CMD>Telescope find_files<CR>')
nnoremap('<leader>fb', '<CMD>Telescope file_browser<CR>')
nnoremap('<leader>fg', '<CMD>Telescope live_grep<CR>')
nnoremap('<leader>bu', '<CMD>Telescope buffers<CR>')
