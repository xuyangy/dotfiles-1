vim.cmd('colorscheme nvcode')
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')
vim.cmd('highlight Normal ctermbg=black')
vim.cmd('highlight Normal guibg=black')

vim.o.shell = '/bin/bash' -- zsh starts too slow for fugitive, but also term:// starts bash instead of zsh
vim.o.termguicolors= true
vim.o.ruler=         true
vim.o.wildmenu=      true
vim.o.autoread=      true
vim.o.ignorecase=    true
vim.o.smartcase=     true
vim.o.hidden=        true
vim.o.completeopt=  'menuone,noinsert,noselect'

vim.wo.number=          true
vim.wo.relativenumber=  true

--vim.bo.omnifunc=vim.lsp.omnifunc -- its rekt
vim.o.tabstop=    2
vim.bo.tabstop=    2

vim.o.shiftwidth= 2
vim.bo.shiftwidth= 2

vim.o.expandtab=  true
vim.bo.expandtab=  true

vim.o.swapfile = false
vim.bo.swapfile = false
