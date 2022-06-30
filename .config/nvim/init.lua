local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

Paq = require('paq').paq

Paq'savq/paq-nvim'
Paq'lukas-reineke/indent-blankline.nvim'
require"indent_blankline".setup {
  show_current_context = true,
  show_current_context_start = true,
}
Paq{url='https://tpope.io/vim/fugitive.git'}
Paq{url='https://tpope.io/vim/rhubarb.git'}
  Paq{url='https://github.com/tyru/open-browser.vim.git'} -- need to disable enable_ex in rnvimr
  vim.api.nvim_exec('command! -nargs=1 Browse OpenBrowser <args>', true); -- nne
  vim.api.nvim_exec([[
    let g:openbrowser_browser_commands = [
        \ {"name": "open",
        \  "args": ["{browser}", "{uri}"],
        \  "background": 0}
        \]
  ]], true)

Paq 'TimUntersberger/neogit'
local neogit = require('neogit')
neogit.setup{}

Paq{url='https://tpope.io/vim/fugitive.git'}


vim.api.nvim_create_autocmd('FileType', {
	pattern = "fugitive",
	once = true,
	callback =
		function()
			print("Filetype autocmd")
			local fugitive_opts = {noremap = true, silent = true};
			vim.api.nvim_buf_set_keymap(0, 'n', 'cc', '<cmd>Git commit --quiet<CR>', fugitive_opts)
			vim.api.nvim_buf_set_keymap(0, 'n', 'ca', '<cmd>Git commit --quiet --amend<CR>', fugitive_opts)
			vim.api.nvim_buf_set_keymap(0, 'n', 'ce', '<cmd>Git commit --quiet --amend --no-edit<CR>', fugitive_opts)
	end
})
Paq'windwp/nvim-ts-autotag'
Paq'windwp/nvim-autopairs'
Paq'machakann/vim-sandwich'
Paq'lambdalisue/suda.vim'
Paq{'iamcco/markdown-preview.nvim', run ='cd app && yarn install'}
Paq'mboughaba/i3config.vim'

Paq'numToStr/Comment.nvim'
require'Comment'.setup()

Paq'lervag/vimtex'
vim.g.vimtex_compiler_latexmk = {
  options = {
    '-pdflatex="xelatex --shell-escape %O %S"',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  }
}

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.mapleader=       ' '
vim.opt.inccommand=    'split' -- semblance of ide search and replace
vim.opt.completeopt=   'menuone,noinsert,noselect' --for nvim-cmp
vim.opt.signcolumn=    'yes' -- avoid layout shift when lsp diagnostics appear
vim.opt.showmode=      false -- for lualine
vim.opt.termguicolors= true
vim.opt.ruler=         true
vim.opt.wildmenu=      true
vim.opt.autoread=      true
vim.opt.ignorecase=    true
vim.opt.smartcase=     true
vim.opt.hidden=        true
vim.opt.confirm=       true -- can't shortmess E162 :(
vim.opt.shm:append('I') -- print(vim.inspect(vim.opt.shm:get())), really cool terse sttings here
vim.opt.cursorline=    true
vim.opt.equalalways=   true

vim.opt.number=        true
vim.opt.relativenumber=true

vim.opt.tabstop=       2
vim.opt.shiftwidth=    2
vim.opt.shiftround=    true
vim.opt.expandtab=     true
vim.opt.swapfile=      false

