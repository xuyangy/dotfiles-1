Paq 'mfussenegger/nvim-dap'

local dap = require('dap')
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
