nnoremap {'<leader>ve', '<cmd>e $MYVIMRC<cr>'}
nnoremap {'<leader>w', '<cmd>w<cr>'}
nnoremap {'<leader>x', '<cmd>x<cr>'}
nnoremap {'<leader>q', '<cmd>q<cr>'}
nnoremap {'<leader>=', '<C-w>='}
nnoremap {'<leader>1', '<cmd>only<cr>'}
nnoremap {'<leader>.', '<cmd>so %<cr>'}
nnoremap {'<C-j>', '<C-w><C-j>'}
nnoremap {'<C-k>', '<C-w><C-k>'}
nnoremap {'<C-h>', '<C-w><C-h>'}
nnoremap {'<C-l>', '<C-w><C-l>'}
nnoremap {'y%', '<cmd>let @+=@%<cr>'}
nnoremap {'<F12>', '<cmd>ccl<cr>'}
nnoremap {'<down>', '<cmd>cn<cr>'}
nnoremap {'<up>', '<cmd>cp<cr>'}
nnoremap {'Q', '<Nop>'}
nnoremap {'<f1>', '<cmd>RnvimrToggle<cr>'}
nnoremap {'<leader>s', '<cmd>G<cr>'}
nnoremap {'<leader>gp', '<cmd>G push<cr>' }
nnoremap {'<leader>gf', '<cmd>G fetch<cr>'}
nnoremap {'<leader>gl', '<cmd>G pull<cr>'}
nnoremap {'<leader>2', '<cmd>diffget //2<cr>'}
nnoremap {'<leader>3', '<cmd>diffget //3<cr>'}
nnoremap {'<leader><C-b>', ':G checkout --quiet <C-r>+<cr>:redrawstatus<cr>'}
nnoremap {'<leader>go', '<cmd>Git log<cr>'}
nnoremap {'<leader>g%', '<cmd>Git log %<cr>'}
nnoremap {'<leader>gcb', ':G checkout origin/develop -b' }
nnoremap {'<leader>y', '"+y'}
nnoremap {'<leader>p', '"+p'}
vnoremap {'<leader>y', '"+y'}
vnoremap {'<leader>p', '"+p'}
nnoremap {'<leader>Y', 'gg"+yG'}
tnoremap {'<leader><f1>', '<C-\\><C-n>:RnvimrResize<cr>'}
