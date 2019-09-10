set timeoutlen=1000 ttimeoutlen=0 " some hack because some commands lag
syntax on " syntax highlighting
set nu rnu " line numbers
set autoindent
set wildmenu
set ruler
set hidden
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

set laststatus=2 " lightline
if !has('gui_running')
	  set t_Co=256
endif
set noshowmode

" plugins
call plug#begin('~/.vim/plugged')
" fzf (ctrlp)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'wincent/terminus'
Plug 'dense-analysis/ale'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'skywind3000/asyncrun.vim'
Plug 'mattn/emmet-vim'
call plug#end()

" mappings
map <C-p> :Files<CR>
noremap <C-N> :NERDTreeToggle<CR>
inoremap jk <esc>

