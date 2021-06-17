local options = { noremap = true }
vim.api.nvim_set_keymap('n','<leader>w', '<cmd>w<cr>', options)
vim.api.nvim_set_keymap('n','<leader>q', ':q<cr>', options)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>w', options)

vim.api.nvim_set_keymap('n','<C-j>', '<C-w><C-j>', options)
vim.api.nvim_set_keymap('n','<C-k>', '<C-w><C-k>', options)
vim.api.nvim_set_keymap('n','<C-h>', '<C-w><C-h>', options)
vim.api.nvim_set_keymap('n','<C-l>', '<C-w><C-l>', options)
vim.api.nvim_set_keymap('n','<leader>=', '<C-w>=', options)
--
vim.api.nvim_set_keymap('n','<leader>ve', ':e $MYVIMRC<cr>', options)
vim.api.nvim_set_keymap('n','<down>', ':cn<cr>', options)
vim.api.nvim_set_keymap('n','<up>', ':cp<cr>', options)
vim.api.nvim_set_keymap('n','yfp', ':let @+=@%<cr>', options) -- copy current file path to clipboard
vim.api.nvim_set_keymap('n','Q', '<Nop>', { noremap = true}) 


vim.api.nvim_set_keymap('n','<leader>ll', ':lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>', options)
--vim.api.nvim_set_keymap('t','<esc>', '<C-\\><C-N>', options)



vim.api.nvim_set_keymap( 'n', '<leader>f', '<cmd>lua require(\'telescope.builtin\').git_files()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>F', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', options)

vim.api.nvim_set_keymap( 'n', '<f1>', '<cmd>RnvimrToggle<cr>', options)
vim.api.nvim_set_keymap( 't', '<leader><f1>', '<C-\\><C-n>:RnvimrResize<cr>', options)
vim.api.nvim_set_keymap( 'n', '<f2>', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader><f2>', '<cmd>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>a', '<cmd>lua require(\'telescope.builtin\').git_branches()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>s', '<cmd>G<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>b', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>o', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>O', '<cmd>lua require(\'telescope.builtin\').lsp_workspace_symbols()<cr>', options)

vim.api.nvim_set_keymap( 'n', '<leader>gp', '<cmd>Gpush<cr>' , options)
vim.api.nvim_set_keymap( 'n', '<leader>gf', '<cmd>Gfetch<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gl', '<cmd>Gpull<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>go', '<cmd>Gcl<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gO', '<cmd>Gcl %<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>gcb', ':G checkout origin/develop -b' , options)
vim.api.nvim_set_keymap( 'n', '<leader>x', 'mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F', options)

vim.api.nvim_set_keymap( 'n', '<leader>y', '"+y', options)
vim.api.nvim_set_keymap( 'v', '<leader>y', '"+y', options)
vim.api.nvim_set_keymap( 'n', '<leader>Y', 'gg"+yG', options)

vim.api.nvim_set_keymap( 'n', '<F12>', '<cmd>ccl<cr>', options)


vim.api.nvim_set_keymap( 'i', '<C-e>', '<C-o>$', options)

vim.api.nvim_set_keymap( 'i', '<C-Space>', "compe#complete()", {noremap = true, expr = true, silent = true})
--vim.api.nvim_set_keymap( 'i', '<CR>', [[compe#confirm('<CR>')]], {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap( 'i', '<silent><expr> <C-e>', 'compe#close(\'<C-e>\')', options)

vim.api.nvim_set_keymap( 'n', '<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<cr>', options)
vim.api.nvim_set_keymap( 'n', '<leader>dl', '<cmd>lua require\'dap\'.continue()<cr>', options)

vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', options)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', options)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
vim.api.nvim_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', options)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)
--vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', options)
vim.api.nvim_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
--for some reason the diagnosticls formatter works only for vue files, see maps.lua for manual format
vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua vim.lsp.buf.formatting()<CR>", options)
