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
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.cycle_history_next,
        ["<C-h>"] = actions.cycle_history_prev,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
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
      path_display = {shorten = 4},
    }
  }
}

telescope.load_extension('fzf')
telescope.load_extension('frecency')
telescope.load_extension('git_worktree') -- rarely use this
-- telescope.load_extension('smart_history') -- config from github can't find .sqlite file for some reason

local function telescope_smart_files()
  if not pcall(builtin.git_files) then
    builtin.find_files()
  end
end

local function grep_cword()
  builtin.grep_string({search = vim.fn.expand("<cword>")})
end

nnoremap {'<leader>f', telescope_smart_files}
nnoremap {'<leader>F', ':lua require(\'telescope\').extensions.frecency.frecency()<cr>:CWD:'}
nnoremap {'<f4>', builtin.live_grep}
nnoremap {'<leader>a', builtin.git_branches}
nnoremap {'<leader>b', builtin.buffers}
nnoremap {'<leader>o', builtin.lsp_document_symbols}
nnoremap {'<leader>O', builtin.lsp_workspace_symbols}
nnoremap {'<leader><leader>', builtin.resume} --holy shit
nnoremap {'<leader>gw', telescope.extensions.git_worktree.git_worktrees }
nnoremap {'<leader><f4>', grep_cword }
