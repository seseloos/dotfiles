local dap = require('dap')
local dapui = require('dapui')

-- Go adapter (uses delve)
require('dap-go').setup()

-- Python adapter (uses debugpy)
require('dap-python').setup(vim.fn.exepath('python3'))

-- DAP UI
dapui.setup()

-- Inline variable values
require('nvim-dap-virtual-text').setup()

-- Auto-open / close DAP UI with debug session
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- Keymaps — <leader>d* (non-overlapping with diagnostic <leader>dn/dp/dl)
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<leader>dc', dap.continue, opts)
vim.keymap.set('n', '<leader>di', dap.step_into, opts)
vim.keymap.set('n', '<leader>dv', dap.step_over, opts)
vim.keymap.set('n', '<leader>dx', dap.step_out, opts)
vim.keymap.set('n', '<leader>dr', dap.repl.open, opts)
vim.keymap.set('n', '<leader>du', dapui.toggle, opts)
