vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>=', '<C-w>=')
vim.keymap.set('n', '<leader>1', '<cmd>only<cr>')
vim.keymap.set('n', '<leader>.', '<cmd>so %<cr>')

vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

vim.keymap.set('n', 'y%', '<cmd>let @+=@%<cr>')
vim.keymap.set('n', '<F12>', '<cmd>ccl<cr>')
vim.keymap.set('n', '<up>', '<cmd>cp<cr>')
vim.keymap.set('n', '<down>', '<cmd>cn<cr>')
vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set('n', '<leader>s', '<cmd>G<cr>')
vim.keymap.set('n', '<leader>gp', '<cmd>G push<cr>' )
vim.keymap.set('n', '<leader>gf', '<cmd>G fetch<cr>')
vim.keymap.set('n', '<leader>gl', '<cmd>G pull<cr>')
vim.keymap.set('n', '<leader><C-b>', ':G checkout --quiet <C-r>+<cr>:redrawstatus<cr>')
vim.keymap.set('n', '<leader>go', '<cmd>G log<cr>')
vim.keymap.set('n', '<leader>g%', '<cmd>G log %<cr>')
vim.keymap.set('n', '<leader>gh', '<cmd>GBrowse<cr>')

vim.keymap.set('n', '<leader>2', '<cmd>diffget //2<cr>')
vim.keymap.set('n', '<leader>3', '<cmd>diffget //3<cr>')
vim.keymap.set('n', '<leader>gcb', ':G checkout origin/develop -b' )

vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')

vim.keymap.set({'n', 't'}, '<leader>ot', '<cmd>ToggleTerm<cr>')
