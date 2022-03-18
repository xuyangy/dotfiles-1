Paq 'mfussenegger/nvim-dap'
Paq 'mfussenegger/nvim-dap-python'

require('dap.ext.vscode').load_launchjs()

local dap = require('dap')
local dap_python = require('dap-python')
dap_python.setup('/usr/bin/python')
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dap/firefox/adapter.bundle.js'},
}
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dap/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.set_log_level('TRACE')

local config_ff = {
    type = 'firefox',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 6000,
  }

local config_node = {
  name = 'Debug with Node',
  type = 'node2',
  request = 'launch',
  program = '${file}',
  cwd = vim.fn.getcwd(),
  sourceMaps = true,
  protocol = 'inspector',
  console = 'integratedTerminal',
}

dap.configurations.vue = { config_ff }
dap.configurations.typescript = { config_ff, config_node }
dap.configurations.javascript = { config_ff, config_node }

-- nnoremap {'\\b', dap.toggle_breakpoint}
-- nnoremap {'\\c', dap.continue}
-- nnoremap {'\\o', dap.step_over}
-- nnoremap {'\\i', dap.step_into}
-- nnoremap {'\\r', dap.repl.open}
-- nnoremap {'\\x', function() dap.disconnect() dap.close(); end}
-- --vnoremap {'\\s', '<leader>ds <ESC>:lua require("dap-python").debug_selection()<CR>', { silent = true }}
-- vim.api.nvim_set_keymap( 'v', '<leader>s', "<ESC>:lua require('dap-python').debug_selection()<CR>", {silent = true})
