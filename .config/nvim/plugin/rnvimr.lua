  require'paq-nvim'.paq 'kevinhwang91/rnvimr'
  vim.g.rnvimr_action = {
    ["<CR>"] = 'NvimEdit drop',
    ["<F1>"] = 'NvimEdit quit',
    ['<C-t>'] = 'NvimEdit tabedit',
    ['<C-s>'] = 'NvimEdit split',
    ['<C-v>'] = 'NvimEdit vsplit',
    ['<C-o>'] = 'NvimEdit drop',
    ['gw'] = 'JumpNvimCwd',
    ['yw'] = 'EmitRangerCwd'
  }
  vim.g.rnvimr_enable_ex = 1
  vim.g.rnvimr_enable_picker = 1
