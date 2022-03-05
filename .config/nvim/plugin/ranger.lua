Paq 'kevinhwang91/rnvimr'
nnoremap {'<leader><leader>', '<cmd>RnvimrToggle<cr>'}

vim.g.rnvimr_action = {
  ['<C-t>'] = 'NvimEdit tabedit',
  ['<C-s>'] = 'NvimEdit split', -- disable CTRL+S in your bash/zsh rc
  ['<C-v>'] = 'NvimEdit vsplit',
  ['gw'] = 'JumpNvimCwd',
  ['yw'] = 'EmitRangerCwd'
}
vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_hide_gitignore = 1
