Paq 'nvim-telescope/telescope.nvim'
Paq 'nvim-telescope/telescope-file-browser.nvim'
Paq 'nvim-telescope/telescope-project.nvim'
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
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer
        }
      }
    },
    git_files = {
      path_display = {'smart'},
    },
  }
}

telescope.load_extension "file_browser"
telescope.load_extension "project"

local function telescope_smart_files()
  local ok = pcall(builtin.git_files)
  if not ok then builtin.find_files() end
end

local function grep_cword()
  builtin.grep_string({search = vim.fn.expand("<cword>")})
end

vim.keymap.set('n', '<leader><leader>', telescope_smart_files)
vim.keymap.set('n', '<leader>F', builtin.find_files)
vim.keymap.set('n', '<leader>sp', builtin.live_grep)
vim.keymap.set('n', '<leader>gb', builtin.git_branches)
vim.keymap.set('n', '<leader><', builtin.buffers)
-- vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols)
-- vim.keymap.set('n', '<leader>O', builtin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader><f4>', grep_cword )
-- vim.keymap.set('n', '<leader>n', "<cmd>Telescope file_browser path=~/org<cr>")
vim.keymap.set('n', '<leader>fP', "<cmd>Telescope find_files cwd=~/.config/nvim<cr>")
vim.keymap.set('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>')
vim.keymap.set('n', '<leader>\'', "<cmd>Telescope resume<cr>")
vim.keymap.set('n', '<leader>pp', "<cmd>Telescope project<CR>")
