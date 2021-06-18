require 'paq-nvim'.paq 'hoob3rt/lualine.nvim'


require('lualine').setup{
  options = {
    theme = 'tokyonight',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {
      {
        'filename', 
        path=1
      },
      {
        'diagnostics', 
        sources = {'nvim_lsp'}, 
      }, 
      'location', 
      'progress'
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'fugitive_branch'}
  },
  inactive_sections = {
    lualine_y = {'branch', 'diff'},
  },
}

