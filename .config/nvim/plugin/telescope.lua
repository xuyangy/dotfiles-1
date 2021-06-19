local paq = require'paq-nvim'.paq
--telescope & deps
paq { 'Conni2461/telescope.nvim', branch='cycle_prompt_history' }
  paq 'nvim-lua/popup.nvim' -- dep from readme 1
  paq 'nvim-lua/plenary.nvim' -- dep from readme 2
  paq 'kyazdani42/nvim-web-devicons'
  paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }

local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup{
  defaults = {
    history_location = '~/.local/share/nvim/telescope_history',
    history_limit = 1000, -- default nil (limiter disabled),
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
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
