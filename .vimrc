set timeoutlen=1000 ttimeoutlen=0 " some hack because some commands lag
syntax on " syntax highlighting
set nu rnu " line numbers
set autoindent
set wildmenu
set ruler
set hidden
set t_Co=256
set swapfile
set dir=~/.vimswap
set cursorline

" fzf
set rtp+=~/.fzf
nnoremap <C-p> :GFiles<cr>

" lightline
set laststatus=2 
if !has('gui_running')
	  set t_Co=256
endif
set noshowmode

" ale
let g:ale_fixers = {'javascript':  ['eslint']}

" camelcasemotion
let g:camelcasemotion_key = '<leader>'


" mappings
inoremap jk <esc>

