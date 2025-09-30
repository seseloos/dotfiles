local configs = require 'nvim-treesitter.configs'
configs.setup {
    ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gowork",
        -- "help",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        -- Python/pip requirements
        "requirements",
        "rust",
        "scss",
        "sql",
        "toml",
        "yaml",
    },
    highlight = {
        enable = true
    }
}
