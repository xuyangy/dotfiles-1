local function keymap(mode, map, cmd)
  local options = {noremap = true}
  vim.api.nvim_set_keymap(mode, map, cmd, options)
end

local keymaps = {
  {'n','<leader>ve', '<cmd>e $MYVIMRC<cr>'},
  {'n','<leader>w', '<cmd>w<cr>'},
  {'n','<leader>q', '<cmd>q<cr>'},
  {'n','<leader>=', '<C-w>='},
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
  {'n','<leader>f', '<cmd>lua require(\'telescope.builtin\').git_files()<cr>'},
  {'n','<leader>F', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>'},
  {'n','<leader>s', '<cmd>G<cr>'},
  {'n','<leader>gp', '<cmd>G push<cr>' },
  {'n','<leader>gf', '<cmd>G fetch<cr>'},
  {'n','<leader>gl', '<cmd>G pull<cr>'},
  {'n','<leader>gpb', ':G checkout <C-r>+<cr>'},
  {'n','<leader>go', '<cmd>GV<cr>'},
  {'n','<leader>gO', '<cmd>GV!<cr>'},
  {'n','<leader>gcb', ':G checkout origin/develop -b' },
  {'n','<leader>x', 'mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F'},
  {'n','<leader>y', '"+y'},
  {'v','<leader>y', '"+y'},
  {'n','<leader>Y', 'gg"+yG'},
  {'i','<silent><expr> <C-e>', 'compe#close(\'<C-e>\')'},
  {'n','<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<cr>'},
  {'n','<leader>dl', '<cmd>lua require\'dap\'.continue()<cr>'},
  {'n','<leader>ll', ':lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>'},
  {'n','gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>'},
  {'n','gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'},
  {'n','K', '<cmd>lua vim.lsp.buf.hover()<CR>'},
  {'n','gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
  {'n','<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'},
  {'n','<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
  {'n','<f2>', '<cmd>lua vim.lsp.buf.rename()<CR>'},
  {'n','gr', '<cmd>lua vim.lsp.buf.references()<CR>'},
  {'n','<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
  {'n','[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
  {'n',']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'},
  {'n','<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>'},
  {'n','<leader>x', '<cmd>lua vim.lsp.buf.formatting()<CR>'},
}

for _,mymap in pairs(keymaps) do
  keymap(mymap[1], mymap[2], mymap[3])
end

vim.api.nvim_set_keymap( 'i', '<C-Space>', "compe#complete()", {noremap = true, expr = true, silent = true})

