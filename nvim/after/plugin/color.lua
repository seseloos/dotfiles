-- background
vim.opt.background = "dark"

-- misc
vim.opt.termguicolors = true

-- catppuccin setup
vim.g.catppuccin_flavor = "mocha"
require('catppuccin').setup({
    transparent_background = true, -- disables setting the background color
    integrations = {
        cmp = true,
        telescope = true,
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { 'italic' },
                hints = { 'italic' },
                warnings = { 'italic' },
                information = { 'italic' },
            },
            underlines = {
                errors = { 'underline' },
                hints = { 'underline' },
                warnings = { 'underline' },
                information = { 'underline' },
            },
        },
    },
})

-- color scheme
vim.cmd[[colorscheme catppuccin]]
