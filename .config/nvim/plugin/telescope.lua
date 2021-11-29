Paq 'nvim-telescope/telescope.nvim'
Paq 'nvim-lua/plenary.nvim'
Paq 'kyazdani42/nvim-web-devicons'

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
  pickers = {
    buffers = {
      sort_lastused = true,
      selection_strategy="closest",
    },
    git_files = {
      path_display = {'smart'},
    },
  }
}

local function telescope_smart_files()
  local ok = pcall(builtin.git_files)
  if not ok then builtin.find_files() end
end

local function grep_cword()
  builtin.grep_string({search = vim.fn.expand("<cword>")})
end

nnoremap {'<leader>f', telescope_smart_files}
nnoremap {'<leader>F', builtin.find_files}
nnoremap {'<f4>', builtin.live_grep}
nnoremap {'<leader>a', builtin.git_branches}
nnoremap {'<leader>b', builtin.buffers}
nnoremap {'<leader>o', builtin.lsp_document_symbols}
nnoremap {'<leader>O', builtin.lsp_workspace_symbols}
nnoremap {'<leader><f4>', grep_cword }
nnoremap {'<leader>n', function() builtin.file_browser{cwd= "~/Nextcloud/Notes/org" } end}
