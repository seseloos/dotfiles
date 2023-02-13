--
-- Setup neodev
-- MUST be done before lspconfig
require('neodev').setup({})

local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local luasnip = require 'luasnip'
local cmp = require 'cmp'

-- Add additional capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- NEEDS to be DISABLED when using `nvim-cmp` for the autocompletion
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
    -- [R]e[n]ame
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- [C]ode [A]ction
    vim.keymap.set('n', 'leader>ca', vim.lsp.buf.code_action, bufopts)
    -- [G]oto [R]eferences
    vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, bufopts)
    -- [G]oto [I]mplementation
    vim.keymap.set('n', '<leader>gI', vim.lsp.buf.implementation, bufopts)
    -- [O]pen [D]iagnostic float
    vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float, bufopts)
    -- [D]iagnostic Goto [N]ext
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, bufopts)
    -- [D]iagnostic Goto [P]revious
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, bufopts)
    -- [D]iagnostic set [L]oc list
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
end

--
-- Setup LSP for Go
lspconfig.gopls.setup {
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
}


-- Helper function that orders Go imports on save, like `goimports`
function go_org_imports(timeout_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }

    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeout_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

-- Run `gofmt` before writting a buffer
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.go' },
    callback = function()
        vim.lsp.buf.formatting_sync(nil, 3000)
    end,
})

-- Organize Go imports before writting a buffer
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.go' },
    callback = function()
        go_org_imports(3000)
    end,
})

--
-- Setup LSP for Lua
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- used Lua version
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            completion = {
                -- enable call snippets and configure it to use folke/neodev
                callSnippet = "Replace"
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

--
-- Setup LSP for YAML
lspconfig.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_dir = function(fname)
        return util.find_git_ancestor(fname)
    end,
    settings = {
        yaml = {
            -- schemas = {
            --     ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "*api.yml"
            -- },
        },
        redhat = {
            telemetry = { enabled = false },
        },
    },
}

--
-- Setup autocompletion with `nvim-cmp`
-- Setup nvim-cmp
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
