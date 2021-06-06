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

vim.api.nvim_set_keymap( 'n', '<leader>a', '<cmd>lua require(\'telescope.builtin\').git_branches()<cr>', options)
vim.api.nvim_set_keymap( 'n', 'ss', ':G<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>f', '<cmd>lua require(\'telescope.builtin\').git_files()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>F', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>g', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>Gr', ':Telescope grep_string search=<C-R><C-W><cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>o', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>O', '<cmd>lua require(\'telescope.builtin\').lsp_workspace_symbols()<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>gp', '<cmd>Gpush<cr>' , options)
vim.api.nvim_set_keymap( 'n', '<leader>gf', '<cmd>Gfetch<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gl', '<cmd>Gpull<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>go', '<cmd>Gcl<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gO', '<cmd>Gcl %<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gcb', ':G checkout origin/develop -b' , options)
vim.api.nvim_set_keymap( 'n', '<space>f', 'mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F', options)

vim.api.nvim_set_keymap( 'n', '<F12>', '<cmd>ccl<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>p', ':RnvimrToggle<cr>', options)
vim.api.nvim_set_keymap( 't', '<leader>P', '<C-\\><C-n>:RnvimrResize<cr>', options)

vim.api.nvim_set_keymap( 'i', '<C-e>', '<C-o>$', options)

vim.api.nvim_set_keymap( 'i', '<C-Space>', "compe#complete()", {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap( 'i', '<CR>', [[compe#confirm('<CR>')]], {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap( 'i', '<silent><expr> <C-e>', 'compe#close(\'<C-e>\')', options)

