set timeoutlen=1000 ttimeoutlen=0 " some hack because some commands lag
syntax on " syntax highlighting
set nu rnu " line numbers
set autoindent
set wildmenu
set ruler
set hidden
set t_Co=256

" open git commit in insert mode
autocmd FileType gitcommit exec 'au VimEnter * startinsert'

" NERDTree
let NERDTreeMinimalUI=1
let g:NERDTreeWinPos = "right"

" fzf
set rtp+=~/.fzf

" vim-devicons
set encoding=UTF-8

" lightline
set laststatus=2 
if !has('gui_running')
	  set t_Co=256
endif
set noshowmode

" mappings
map <C-p> :Files<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
inoremap jk <esc>

