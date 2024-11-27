-- Create an augroup for Markdown settings
local markdown_group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

-- text width
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal textwidth=120",
    group = markdown_group,
})

-- enable wrapping
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal wrap",
    group = markdown_group,
})

-- enable linebreak
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal linebreak",
    group = markdown_group,
})

