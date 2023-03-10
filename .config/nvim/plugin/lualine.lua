Paq'nvim-lualine/lualine.nvim'
Paq'arkav/lualine-lsp-progress'
Paq'SmiteshP/nvim-gps'

local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local function lspcount()
  local count = 0
  for _ in pairs(vim.lsp.buf_get_clients()) do
    count = count + 1
  end
  return '👅 ' .. count
end

local function orgmodestatus()
  return vim.api.nvim_eval('v:lua.orgmode.statusline()')
end


local gps = require("nvim-gps")
gps.setup()

require('lualine').setup{
  options = {
    globalstatus = true
  },
  sections={
    lualine_b={
      {'filetype', icon_only = true, separator = '' },
      {'filename', path = 1, shorting_target = 40, padding = 0 },
    },
    lualine_c = {
      { gps.get_location, cond = gps.is_available }
    },
    lualine_x={
      -- {
      --   'lsp_progress',
      --   colors = {
      --     lsp_client_name = colors.yellow,
      --     title  = colors.cyan,
      --     message  = colors.orange,
      --     percentage  = colors.orange,
      --     spinner = colors.orange,
      --     use = true,
      --   },
      --   display_components = {'lsp_client_name', {'title', 'message', 'percentage'}, 'spinner'},
      --   separators = {
      --     message = {commenced = ".", completed = 'OK'}
      --   }
      -- },
      orgmodestatus
      
    },
    lualine_y={
      {'diagnostics', sources={'nvim_diagnostic', 'coc'}, separator = '', padding = 0},
      lspcount,
    },
    lualine_z={
      'diff',
      'branch',
    }
  },
}
