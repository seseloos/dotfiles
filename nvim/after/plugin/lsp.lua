-- Setup lazydev (replaces neodev.nvim) — must be before LSP configs
require('lazydev').setup({})

local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

-- Capabilities via blink.cmp (replaces cmp-nvim-lsp)
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Buffer-local keymaps applied on LSP attach
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- [R]e[n]ame
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- [C]ode [A]ction
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- [G]oto [R]eferences
    vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, bufopts)
    -- [G]oto [I]mplementation
    vim.keymap.set('n', '<leader>gI', vim.lsp.buf.implementation, bufopts)
    -- [O]pen [D]iagnostic float
    vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float, bufopts)
    -- [D]iagnostic Goto [N]ext / [P]revious
    vim.keymap.set('n', '<leader>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end, bufopts)
    vim.keymap.set('n', '<leader>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end, bufopts)
    -- [D]iagnostic set [L]oc list
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
end

--
-- Go
vim.lsp.config('gopls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
        gopls = {
            usePlaceholders = true,
        },
    },
})
vim.lsp.enable('gopls')

--
-- Lua
vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            completion = {
                callSnippet = "Replace"
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
vim.lsp.enable('lua_ls')

--
-- YAML (with SchemaStore schemas for docker-compose, GH Actions, k8s, etc.)
vim.lsp.config('yamlls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    settings = {
        yaml = {
            schemas = require('schemastore').yaml.schemas(),
        },
        redhat = {
            telemetry = { enabled = false },
        },
    },
})
vim.lsp.enable('yamlls')

--
-- Python — Ruff (linting + formatting)
vim.lsp.config('ruff', {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        settings = {},
    }
})
vim.lsp.enable('ruff')

-- Disable Ruff hover in favor of Pyright
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then return end
        if client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = 'LSP: Disable hover capability of ruff',
})

--
-- Python — Pyright (type checking, hover)
vim.lsp.config('pyright', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = { '*' },
            },
        },
    },
})
vim.lsp.enable('pyright')

--
-- Docker — Dockerfile
vim.lsp.config('dockerls', {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable('dockerls')

--
-- Docker — docker-compose (filetype set by lspconfig's ftdetect)
vim.lsp.config('docker_compose_language_service', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'yaml.docker-compose' },
})
vim.lsp.enable('docker_compose_language_service')

--
-- Markdown
vim.lsp.config('marksman', {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable('marksman')
