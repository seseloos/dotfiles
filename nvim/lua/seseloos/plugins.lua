local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- treesitter
    'nvim-treesitter/nvim-treesitter',

    -- lsp
    'neovim/nvim-lspconfig', -- collection of configurations for neovim built-in LSP client
    "williamboman/mason.nvim", -- managing LSP server, DAP server, linters and formatters
    "williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason and lspconfig

    -- autocompletion
    'hrsh7th/nvim-cmp', -- autocompletion plugin/engine
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'folke/neodev.nvim', -- autocompletion for nvim lua API

    -- snippets
    'saadparwaiz1/cmp_luasnip', -- snippets source for nvim-cmp
    'L3MON4D3/LuaSnip', -- snippets plugin/engine

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    'nvim-telescope/telescope-file-browser.nvim',

    -- editing
    'tpope/vim-commentary', -- motions for commenting stuff out
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

    -- util
    {
       "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
       opts = {}
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
