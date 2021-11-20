local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

Paq = require('paq-nvim').paq
local plugins = {
  -- plugins that dont need their own file
  'savq/paq-nvim',
  'lukas-reineke/indent-blankline.nvim',
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'windwp/nvim-autopairs',
  'machakann/vim-sandwich',
  'lambdalisue/suda.vim',
  'tjdevries/astronauta.nvim',
  {'iamcco/markdown-preview.nvim', run ='cd app && yarn install'},
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

vim.g.mapleader=       ' '
vim.opt.inccommand=    'split' -- semblance of ide search and replace
vim.opt.completeopt=   'menuone,noinsert,noselect' --for nvim-cmp
vim.opt.signcolumn=    'yes' -- avoid layout shift when lsp diagnostics appear
vim.opt.showmode=      false -- for lualine
vim.opt.termguicolors= true
vim.opt.ruler=         true
vim.opt.wildmenu=      true
vim.opt.autoread=      true
vim.opt.ignorecase=    true
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

