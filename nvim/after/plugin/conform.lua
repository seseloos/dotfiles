require('conform').setup({
    formatters_by_ft = {
        go       = { 'goimports', 'gofumpt' },
        python   = { 'ruff_format', 'ruff_organize_imports' },
        lua      = { 'stylua' },
        yaml     = { 'prettier' },
        markdown = { 'prettier', 'markdownlint-cli2' },
        json     = { 'prettier' },
        sh       = { 'shfmt' },
    },
    format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 1500,
    },
})

-- [F]or[M]at current buffer
vim.keymap.set('n', '<leader>fm', function()
    require('conform').format({ lsp_format = 'fallback' })
end, { noremap = true, silent = true })
