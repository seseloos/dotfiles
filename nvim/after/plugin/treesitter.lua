local configs = require 'nvim-treesitter.configs'
configs.setup {
    ensure_installed = {
        "bash",
        "css",
        "go",
        "gomod",
        "gowork",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "regex",
        "rust",
        "scss",
        "toml",
        "yaml",
    },
    highlight = {
        enable = true
    }
}