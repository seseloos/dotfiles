local lint = require('lint')

lint.linters_by_ft = {
    go         = { 'golangcilint' },
    dockerfile = { 'hadolint' },
    markdown   = { 'markdownlint-cli2' },
    make       = { 'checkmake' },
    yaml       = { 'yamllint' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    callback = function()
        lint.try_lint()
    end,
})
