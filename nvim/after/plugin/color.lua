-- background
vim.opt.background = "dark"

-- misc
vim.opt.termguicolors = true

-- catppuccin setup
require('catppuccin').setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        blink_cmp = true,
        telescope = true,
        treesitter = true,
        gitsigns = true,
        dap = true,
        dap_ui = true,
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
