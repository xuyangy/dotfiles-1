require('sets')
require('maps')

vim.cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
plugins = {
  {'savq/paq-nvim', opt=true },
  { 'lukas-reineke/indent-blankline.nvim', branch='lua' },
  'folke/tokyonight.nvim',
  'tpope/vim-fugitive',
  'windwp/nvim-ts-autotag',
  'machakann/vim-sandwich',
  'windwp/nvim-autopairs',
  'lambdalisue/suda.vim'
}
for _,plugin in ipairs(plugins) do
  paq(plugin)
end

vim.cmd('runtime macros/sandwich/keymap/surround.vim')
