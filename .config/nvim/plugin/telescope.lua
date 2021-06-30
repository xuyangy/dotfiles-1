--telescope & deps
Paq { 'Conni2461/telescope.nvim', branch='cycle_prompt_history' }
  Paq 'nvim-lua/popup.nvim' -- dep from readme 1
  Paq 'nvim-lua/plenary.nvim' -- dep from readme 2
  Paq 'kyazdani42/nvim-web-devicons'
  Paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }
  Paq 'ThePrimeagen/git-worktree.nvim'

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
        ["<Up>"] = actions.cycle_history_next,
        ["<Down>"] = actions.cycle_history_prev,
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
telescope.load_extension('git_worktree')
