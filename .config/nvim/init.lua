vim.cmd 'packadd paq-nvim'
function Keymap(mode, map, cmd)
  local options = { noremap = true }
  vim.api.nvim_set_keymap(mode, map, cmd, options)
end

Plugins = {}
function PaqAdd(plugin_name)
  table.insert(Plugins, plugin_name)
end
_G.Paq = PaqAdd

local plugins = {
  -- plugins that dont need their own file
  'savq/paq-nvim',
  { 'lukas-reineke/indent-blankline.nvim', branch='lua' },
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'machakann/vim-sandwich',
  'windwp/nvim-autopairs',
  'lambdalisue/suda.vim',
  'b3nj5m1n/kommentary',
  'junegunn/gv.vim',
}
for _,plugin in ipairs(plugins) do
  Paq(plugin)
end

--vim.cmd('runtime macros/sandwich/keymap/surround.vim')


vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.mapleader = " "
vim.opt.shell = '/bin/bash' -- zsh starts too slow for fugitive, but also term:// starts bash instead of zsh
vim.opt.termguicolors= true
vim.opt.ruler=         true
vim.opt.wildmenu=      true
vim.opt.autoread=      true
vim.opt.ignorecase=    true
vim.opt.smartcase=     true
vim.opt.hidden=        true
vim.opt.completeopt=   'menuone,noinsert,noselect'
vim.opt.cursorline=    true

vim.opt.number=        true
vim.opt.relativenumber=true

vim.opt.tabstop=       2
vim.opt.shiftwidth=    2
vim.opt.shiftround=    true
vim.opt.expandtab=     true
vim.opt.swapfile=     false
