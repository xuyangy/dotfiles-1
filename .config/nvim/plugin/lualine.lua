require 'paq-nvim'.paq 'hoob3rt/lualine.nvim'

require('lualine').setup{
  options = {
    theme = 'powerline',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {{'filename', path = 1},{'diagnostics', sources = {'nvim_lsp'}, color_error = "#ff0000"},'location', 'progress'},
    lualine_x = {},
    lualine_y = {'branch', 'diff'},
    lualine_z = {}
  },
  inactive_sections = {

    lualine_y = {'branch', 'diff'},
  }
}

