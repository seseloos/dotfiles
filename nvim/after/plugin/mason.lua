local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local mason_tool_installer = require('mason-tool-installer')

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        'lua_ls',
        'gopls',
        'pyright',
        'ruff',
        'yamlls',
        'dockerls',
        'docker_compose_language_service',
        'marksman',
    },
})

-- Non-LSP tools (formatters, linters, debuggers)
mason_tool_installer.setup({
    ensure_installed = {
        -- Go
        'gofumpt',
        'goimports',
        'golangci-lint',
        'delve',
        -- Python
        'debugpy',
        -- Lua
        'stylua',
        -- Shell
        'shfmt',
        -- Web / markdown
        'prettier',
        'markdownlint-cli2',
        -- Docker
        'hadolint',
        -- Make
        'checkmake',
        -- YAML
        'yamllint',
    },
})
