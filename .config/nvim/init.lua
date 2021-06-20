require('sets')
require('maps')

vim.cmd 'packadd paq-nvim'
Paq = require('paq-nvim').paq
local plugins = {
  {'savq/paq-nvim', opt=true },
  { 'lukas-reineke/indent-blankline.nvim', branch='lua' },
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'machakann/vim-sandwich',
  'windwp/nvim-autopairs',
  'lambdalisue/suda.vim',
  'b3nj5m1n/kommentary'
}
for _,plugin in ipairs(plugins) do
  Paq(plugin)
end

vim.cmd('runtime macros/sandwich/keymap/surround.vim')
