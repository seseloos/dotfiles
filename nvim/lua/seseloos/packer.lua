local vim = vim
local fn = vim.fn

-- ensure 'packer' (plugin manager) is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

local packer = require 'packer'
local util = require 'packer.util'

packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
})

packer.startup(function(use)
    -- plugin manager
    use 'wbthomason/packer.nvim'

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- lsp configuration
    use 'neovim/nvim-lspconfig'     -- collection of configurations for neovim built-in LSP client
    use 'hrsh7th/nvim-cmp'          -- autocompletion plugin/engine
    use 'hrsh7th/cmp-nvim-lsp'      -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'  -- snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip'          -- snippets plugin/engine

    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- editing
    use 'tpope/vim-commentary'      -- motions for commenting stuff out

    -- color scheme
    use 'Mofiqul/dracula.nvim'
    use 'folke/tokyonight.nvim'
    use 'catppuccin/nvim'
    use 'EdenEast/nightfox.nvim'

    -- statusline
    use 'nvim-lualine/lualine.nvim'

    -- icons
    use { 'kyazdani42/nvim-web-devicons', opt = true  }
end)
