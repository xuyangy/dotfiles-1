Paq {'nvim-lualine/lualine.nvim' }
Paq {'arkav/lualine-lsp-progress'}
require('lualine').setup{
  options = {
    theme = 'tokyonight',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = {'fugitive'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'filename',
        file_status=true,
        path=2,
      },
    },
    lualine_c = {
      {
        'lsp_progress',
        separators = {
          component = ' ',
          progress = ' | ',
          message = { pre = '', post = ''},
          percentage = { pre = '', post = '%% ' },
          title = { pre = '', post = ': ' },
          lsp_client_name = { pre = '[', post = ']' },
          spinner = { pre = '', post = '' },
          message = { commenced = '⌛', completed = '✔️' },
        },
        display_components = { --[[ 'lsp_client_name', ]] 'spinner', { 'title', 'percentage', 'message' }},
        spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
      }
    },
    lualine_x = {
      'location',
      'progress'
    },
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
      },
      'branch',
    },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_z = {'branch', 'diff'},
  },
}

