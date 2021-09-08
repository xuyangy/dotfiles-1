local opts = {noremap = true, silent = true};
local current_buffer = 0;
vim.api.nvim_buf_set_keymap(current_buffer, 'n', 'cc', '<cmd>Git commit --quiet<CR>', opts)
vim.api.nvim_buf_set_keymap(current_buffer, 'n', 'ce', '<cmd>Git commit --quiet --amend<CR>', opts)
vim.api.nvim_buf_set_keymap(current_buffer, 'n', 'ca', '<cmd>Git commit --quiet --amend --no-edit<CR>', opts)

