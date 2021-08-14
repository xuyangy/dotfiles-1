--telescope & deps
Paq 'nvim-telescope/telescope.nvim'
  Paq 'nvim-lua/popup.nvim' -- dep from readme 1
  Paq 'nvim-lua/plenary.nvim' -- dep from readme 2
  Paq 'kyazdani42/nvim-web-devicons'
  Paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }
  Paq 'ThePrimeagen/git-worktree.nvim'
  Paq 'tami5/sql.nvim'
  Paq 'nvim-telescope/telescope-frecency.nvim'
  -- Paq 'nvim-telescope/telescope-smart-history.nvim'

local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.cycle_history_next,
        ["<C-h>"] = actions.cycle_history_prev,
      },
    },
    dynamic_preview_title = true,
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
    },
    git_files = {
      path_display = {shorten = 2},
    }
  }
}

telescope.load_extension('fzf')
telescope.load_extension('git_worktree') -- rarely use this
telescope.load_extension('frecency') -- rarely use this because it doesn't easily integrate with git_files/find_files
-- telescope.load_extension('smart_history') -- config from github can't find .sqlite file for some reason

_G.telescope_smart_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end
