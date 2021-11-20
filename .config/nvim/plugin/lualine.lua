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
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status=true,
        path=2,
      },
      'lsp_progress'
    },
    lualine_x = {},
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
      },
      'location',
      'progress'
    },
    lualine_z = { 'branch',}
  },
  inactive_sections = {
    lualine_z = {'branch', 'diff'},
  },
}

