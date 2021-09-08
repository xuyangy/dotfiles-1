local keymaps = {
  {'n','<leader>ve', '<cmd>e $MYVIMRC<cr>'},
  {'n','<leader>w', '<cmd>w<cr>'},
  {'n','<leader>q', '<cmd>q<cr>'},
  {'n','<leader>=', '<C-w>='},
  {'n','<leader>1', '<cmd>only<cr>'},
  {'n','<C-j>', '<C-w><C-j>'},
  {'n','<C-k>', '<C-w><C-k>'},
  {'n','<C-h>', '<C-w><C-h>'},
  {'n','<C-l>', '<C-w><C-l>'},
  {'n','y%', '<cmd>let @+=@%<cr>'},
  {'n','<F12>', '<cmd>ccl<cr>'},
  {'n','<down>', '<cmd>cn<cr>'},
  {'n','<up>', '<cmd>cp<cr>'},
  {'n','Q', '<Nop>'},
  {'n','<f1>', '<cmd>RnvimrToggle<cr>'},
  {'t','<leader><f1>', '<C-\\><C-n>:RnvimrResize<cr>'},
  {'n','<f4>', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>'},
  {'n','<leader><f4>', '<cmd>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>'},
  {'n','<leader>a', '<cmd>lua require(\'telescope.builtin\').git_branches()<cr>'},
  {'n','<leader>b', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>'},
  {'n','<leader>o', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>'},
  {'n','<leader>O', '<cmd>lua require(\'telescope.builtin\').lsp_workspace_symbols()<cr>'},
  {'n','<leader>f', '<cmd>lua telescope_smart_files()<cr>'},
  {'n','<leader>F', ':lua require(\'telescope\').extensions.frecency.frecency()<cr>:CWD:'},
  {'n','<leader><leader>', '<cmd>Telescope resume<cr>'}, --holy shit
  {'n','<leader>gw', '<cmd>lua require(\'telescope\').extensions.git_worktree.git_worktrees()<cr>' },
  {'n','<leader>s', '<cmd>G<cr>'},
  {'n','<leader>gp', '<cmd>G push<cr>' },
  {'n','<leader>gf', '<cmd>G fetch<cr>'},
  {'n','<leader>gl', '<cmd>G pull<cr>'},
  {'n','<leader>2', '<cmd>diffget //2<cr>'},
  {'n','<leader>3', '<cmd>diffget //3<cr>'},
  {'n','<leader><C-b>', ':G checkout --quiet <C-r>+<cr>:redrawstatus<cr>'},
  {'n','<leader>go', '<cmd>GV<cr>'},
  {'n','<leader>g%', '<cmd>GV!<cr>'},
  {'n','<leader>gcb', ':G checkout origin/develop -b' },
  {'n','<leader>x', '<cmd>x<cr>'},
  {'n','<leader>y', '"+y'},
  {'v','<leader>y', '"+y'},
  {'n','<leader>p', '"+p'},
  {'v','<leader>p', '"+p'},
  {'n','<leader>Y', 'gg"+yG'},
  {'i','<silent><expr> <C-e>', 'compe#close(\'<C-e>\')'},
  {'n','<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<cr>'},
  {'n','<leader>dl', '<cmd>lua require\'dap\'.continue()<cr>'},
}

for _,mymap in pairs(keymaps) do
  Keymap(mymap[1], mymap[2], mymap[3])
end

vim.api.nvim_set_keymap( 'i', '<C-Space>', "compe#complete()", {noremap = true, expr = true, silent = true})

