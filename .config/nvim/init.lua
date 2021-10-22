vim.cmd 'packadd paq-nvim'
Paq = require('paq-nvim').paq
Paq {'iamcco/markdown-preview.nvim', run ='cd app && yarn install'}
local plugins = {
  -- plugins that dont need their own file
  'ellisonleao/glow.nvim',
  'savq/paq-nvim',
  'lukas-reineke/indent-blankline.nvim',
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'machakann/vim-sandwich',
  'windwp/nvim-autopairs',
  'lambdalisue/suda.vim',
  'junegunn/gv.vim',
  'tjdevries/astronauta.nvim',
  'lewis6991/gitsigns.nvim',
  'tpope/vim-commentary'
}
for _,plugin in ipairs(plugins) do
  Paq(plugin)
end

local keymap = require('astronauta.keymap')
_G.nnoremap = keymap.nnoremap
_G.tnoremap = keymap.tnoremap
_G.vnoremap = keymap.vnoremap
_G.inoremap = keymap.vnoremap

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.mapleader = " "
vim.opt.shell = '/bin/bash' -- zsh starts too slow for fugitive, but also term:// starts bash instead of zsh
vim.opt.termguicolors= true
vim.opt.ruler=         true
vim.opt.wildmenu=      true
vim.opt.autoread=      true
vim.opt.ignorecase=    true
vim.opt.showmode=      false
vim.opt.smartcase=     true
vim.opt.hidden=        true
vim.opt.confirm=       true -- can't shortmess E162 :(
vim.opt.cursorline=    true
vim.opt.equalalways=   true

vim.opt.number=        true
vim.opt.relativenumber=true

vim.opt.tabstop=       2
vim.opt.shiftwidth=    2
vim.opt.shiftround=    true
vim.opt.expandtab=     true
vim.opt.swapfile=      false
