-- background
vim.opt.background = "dark"

-- misc
vim.opt.termguicolors = true

-- tokyonight setup
-- require('tokyonight').setup()

-- catppuccin setup
vim.g.catppuccin_flavor = "mocha"
require('catppuccin').setup({
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
-- vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme tokyonight]]
vim.cmd[[colorscheme catppuccin]]
