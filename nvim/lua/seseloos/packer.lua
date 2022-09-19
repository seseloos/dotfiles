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
    use 'neovim/nvim-lspconfig'

    -- color scheme
    use 'Mofiqul/dracula.nvim'

    -- statusline
    use 'nvim-lualine/lualine.nvim'

    -- icons
    use { 'kyazdani42/nvim-web-devicons', opt = true  }
end)
