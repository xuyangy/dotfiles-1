vim.api.nvim_command([[nnoremap <buffer> <silent> cc :Git commit --quiet<CR>]])
vim.api.nvim_command([[nnoremap <buffer> <silent> ca :Git commit --quiet --amend<CR>]])
vim.api.nvim_command([[nnoremap <buffer> <silent> ce :Git commit --quiet --amend --no-edit<CR>]])
    
