local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
    },

    -- lsp
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- lua dev (replaces neodev.nvim)
    'folke/lazydev.nvim',

    -- completion (replaces nvim-cmp stack)
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
            },
        },
    },

    -- yaml schema validation
    'b0o/SchemaStore.nvim',

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    'nvim-telescope/telescope-file-browser.nvim',

    -- editing
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- git
    'lewis6991/gitsigns.nvim',

    -- color scheme
    'catppuccin/nvim',

    -- statusline
    'nvim-lualine/lualine.nvim',

    -- icons
    'nvim-tree/nvim-web-devicons',

    -- formatters
    'stevearc/conform.nvim',

    -- linters
    'mfussenegger/nvim-lint',

    -- markdown inline rendering
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },

    -- debugging
    'mfussenegger/nvim-dap',
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',

    -- testing
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
    },
    'fredrikaverpil/neotest-golang',
    'nvim-neotest/neotest-python',
}

require("lazy").setup(plugins, {})
