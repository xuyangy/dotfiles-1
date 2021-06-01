vim.g.tokyonight_italic_comments = 1
vim.cmd('colorscheme tokyonight')

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.cmd('highlight LineNr guifg=#888888')
vim.cmd('highlight CursorLineNr guifg=#ffffff')

vim.opt.shell = '/bin/bash' -- zsh starts too slow for fugitive, but also term:// starts bash instead of zsh
vim.opt.termguicolors= true
vim.opt.ruler=         true
vim.opt.wildmenu=      true
vim.opt.autoread=      true
vim.opt.ignorecase=    true
vim.opt.smartcase=     true
vim.opt.hidden=        true
vim.opt.completeopt=  'menuone,noinsert,noselect'
vim.opt.cursorline=    true

vim.opt.number=          true
vim.opt.relativenumber=  true

vim.opt.tabstop=    2
vim.opt.shiftwidth= 2
vim.opt.expandtab=  true
vim.opt.swapfile = false
