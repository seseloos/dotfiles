-- key mappings
vim.g.mapleader = ","		    -- new prefix key

-- line number options
vim.opt.nu = true		        -- show line numbers
vim.opt.relativenumber = true	-- enable relative line numbers

-- cursor options
vim.opt.guicursor = ""		    -- set cursor to be fat
vim.opt.cursorline = true	    -- highlight line under cursor

-- tab options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- vim.opt.breakindent = true

-- search options
-- case insensitive seaching unless /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- line options
vim.opt.wrap = false            -- disable line wrapping

-- window options
vim.opt.laststatus = 3
vim.opt.splitright = true       -- open vertical splits to the right
vim.opt.splitbelow = true       -- open horizontal splits below

-- backup and swap options
vim.opt.backup = false          -- disable backup files
vim.opt.writebackup = false     -- disable writing backup files
vim.opt.swapfile = false        -- disable swap files

-- file and buffer options
vim.opt.autoread = true         -- loading file changes from disk

-- copy/paste/cut options
vim.opt.clipboard = "unnamedplus"   -- enable y and p with the system clipboard

-- misc options
vim.opt.scrolloff = 20          -- number of lines to keep above and below the cursor

