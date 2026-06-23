require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono',
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true },
})
