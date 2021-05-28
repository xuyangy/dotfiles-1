local options = { noremap = true }
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>w', options)

vim.api.nvim_set_keymap('n','<C-j>', '<C-w><C-j>', options)
vim.api.nvim_set_keymap('n','<C-k>', '<C-w><C-k>', options)
vim.api.nvim_set_keymap('n','<C-h>', '<C-w><C-h>', options)
vim.api.nvim_set_keymap('n','<C-l>', '<C-w><C-l>', options)
vim.api.nvim_set_keymap('n','<leader>=', '<C-w>=', options)
--vim.api.nvim_set_keymap('n','<leader>q', ':q<cr>', options)
vim.api.nvim_set_keymap('n','<leader>w', ':w<cr>', options)
vim.api.nvim_set_keymap('n','<leader>ve', ':e $MYVIMRC<cr>', options)
vim.api.nvim_set_keymap('n','<down>', ':cn<cr>', options)
vim.api.nvim_set_keymap('n','<up>', ':cp<cr>', options)
vim.api.nvim_set_keymap('n','yfp', ':let @+=@%<cr>', options) -- copy current file path to clipboard


vim.api.nvim_set_keymap('n','<leader>ll', ':lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>', options)
--vim.api.nvim_set_keymap('t','<esc>', '<C-\\><C-N>', options)

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>Telescope git_branches<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>s', ':G<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope git_files<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>g', '<cmd>Telescope live_grep<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>F', '<cmd>Telescope find_files<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>tG', ':Telescope grep_string search=<C-R><C-W><cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>ts', '<cmd>Telescope lsp_document_symbols<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>tS', '<cmd>Telescope lsp_workspace_symbols<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>td', '<cmd>Telescope lsp_document_diagnostics<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>tD', '<cmd>Telescope lsp_workspace_diagnostics<cr>', options)


vim.api.nvim_set_keymap( 'n', '<leader>ggp', ':G -c push.default=current push<CR>' , options)
vim.api.nvim_set_keymap( 'n', '<leader>gL', ':G pull', options)
vim.api.nvim_set_keymap( 'n', '<leader>gcb', ':G checkout origin/develop -b' , options)
vim.api.nvim_set_keymap( 'n', '<leader>glo', '<cmd>Gcl<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>glO', '<cmd>Gcl %<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gf', ':G fetch<cr>', options)
vim.api.nvim_set_keymap( 'n', '<space>f', 'mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F', options)

vim.api.nvim_set_keymap( 'n', '<silent>w', '<Plug>CamelCaseMotion_w', options)
vim.api.nvim_set_keymap( 'n', '<silent>b', '<Plug>CamelCaseMotion_b', options)

vim.api.nvim_set_keymap( 'n', '<leader>p', ':RnvimrToggle<cr>', options)
vim.api.nvim_set_keymap( 't', '<leader>P', '<C-\\><C-n>:RnvimrResize<cr>', options)

vim.api.nvim_set_keymap( 'i', '<C-e>', '<C-o>$', options)

vim.api.nvim_set_keymap( 'i', '<C-Space>', "compe#complete()", {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap( 'i', '<CR>', [[compe#confirm('<CR>')]], {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap( 'i', '<silent><expr> <C-e>', 'compe#close(\'<C-e>\')', options)

