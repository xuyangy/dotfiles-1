Paq 'mfussenegger/nvim-dap'
Paq 'mfussenegger/nvim-dap-python'

local dap = require('dap')
local dap_python = require('dap-python')
dap_python.setup('/usr/bin/python')
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dap/firefox/adapter.bundle.js'},
}
dap.set_log_level('TRACE')

local config = {
    name = 'Debug with Firefox',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    url = 'http://localhost:3000',
    webRoot = '${workspaceFolder}',
    --[[ pathMappings = {
      {
        url = 'http://localhost:3000',
        path = "${workspaceFolder}"
      }
    }, ]]
    firefoxExecutable = '/usr/bin/firefox-nightly'
  }

dap.configurations.vue = { config }
dap.configurations.typescript = { config }

nnoremap {'\\b', dap.toggle_breakpoint}
nnoremap {'\\c', dap.continue}
nnoremap {'\\o', dap.step_over}
nnoremap {'\\i', dap.step_into}
nnoremap {'\\r', dap.repl.open}
--vnoremap {'\\s', '<leader>ds <ESC>:lua require("dap-python").debug_selection()<CR>', { silent = true }}
vim.api.nvim_set_keymap( 'v', '<leader>s', "<ESC>:lua require('dap-python').debug_selection()<CR>", {silent = true})
