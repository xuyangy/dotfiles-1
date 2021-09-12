Paq 'mfussenegger/nvim-dap'

local dap = require('dap')
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dap/firefox-adapter.js'},
}
dap.configurations.vue = {
  {
    type = 'firefox',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    firefoxExecutable = '/usr/bin/firefox-nightly',
    url = 'http://localhost:3333',
    webRoot = '${workspaceFolder}'
  }
}

nnoremap {'\\b', dap.toggle_breakpoint}
nnoremap {'\\c', dap.continue}
nnoremap {'\\o', dap.setp_over}
nnoremap {'\\i', dap.step_into}
nnoremap {'\\r', dap.repl_open}
