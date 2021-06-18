local paq = require'paq-nvim'.paq
--telescope & deps
paq 'nvim-telescope/telescope.nvim'
  paq 'nvim-lua/popup.nvim' -- dep from readme 1
  paq 'nvim-lua/plenary.nvim' -- dep from readme 2
  paq 'kyazdani42/nvim-web-devicons'
  paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }

local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

telescope.load_extension('fzf')
