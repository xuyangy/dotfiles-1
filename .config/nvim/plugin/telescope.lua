--telescope & deps
Paq { 'Conni2461/telescope.nvim', branch='cycle_prompt_history' }
  Paq 'nvim-lua/popup.nvim' -- dep from readme 1
  Paq 'nvim-lua/plenary.nvim' -- dep from readme 2
  Paq 'kyazdani42/nvim-web-devicons'
  Paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }
  Paq 'ThePrimeagen/git-worktree.nvim'
  Paq 'tami5/sql.nvim'
  Paq 'nvim-telescope/telescope-frecency.nvim'

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
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      selection_strategy="closest",
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer },
      }
    },
    git_files = {
      shorten_path = true,
    }
  }
}

telescope.load_extension('fzf')
telescope.load_extension('git_worktree')
telescope.load_extension('frecency')

_G.telescope_smart_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end
