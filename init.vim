syntax enable 
filetype plugin indent on
" search down subfolders in :find completion, but ignore node_modules
set path+=** wildignore+=**/node_modules/**
set rnu nu tabstop=2 shiftwidth=2 expandtab nocompatible smartcase wildmenu noswapfile autoread
set shell=/bin/bash " zsh slow with vim-fugitive :Gstatus

tnoremap <Esc> <C-\><C-n>
nmap <C-j> <C-w>w
nmap <C-k> <C-w>W

" open git commit in insert mode
autocmd FileType gitcommit exec 'au VimEnter * startinsert'

" netrw
  let g:netrw_liststyle    = 3                                " tree view (expandable folders) https://shapeshed.com/vim-netrw/
  let g:netrw_banner       = 0                                " remove tips at top
  let g:netrw_browse_split = 2                                " open entered file to side split rather than replacing netrw split
  let g:netrw_bufsettings  = 'noma nomod nu nobl nowrap ro'   " netrw line numbers https://stackoverflow.com/a/8731175/10706046
  let g:netrw_winsize      = 25

call plug#begin()
  
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         " https://www.erickpatrick.net/blog/adding-syntax-highlighting-to-fzf.vim-preview-window
  Plug 'junegunn/fzf.vim'
    map <C-p> :Files<CR>
    let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.9  }}
    let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"

  Plug 'stsewd/fzf-checkout.vim'
    nmap <leader>go :GBranches checkout<CR>

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
    map <leader>s :CocList outline<CR>
    map <leader>S :CocList symbols<CR>
    map <leader>F :CocList grep 
  Plug 'dense-analysis/ale'
    let g:ale_fixers = {} 
    let g:ale_fixers.typescript = ['prettier', 'eslint']
    let g:ale_fixers.javascript = ['prettier', 'eslint']
    let g:ale_fixers.vue = ['prettier', 'eslint']
  Plug 'neoclide/coc-vetur'
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

  " syntax highl
  Plug 'posva/vim-vue'
    let g:vue_pre_processors = ['typescript', 'scss']

  "misc
  Plug 'dracula/vim', {'as': 'dracula'}
    colorscheme dracula
    highlight Normal ctermbg=black
  Plug 'tpope/vim-fugitive'
    nmap <leader>gsb :G<CR>
    nmap <leader>gc :Gcommit<CR>
    " don't ask to set upstream
    nmap <leader>gp :G -c push.default=current push<CR> 
    nmap <leader>gl :Gpull 
  Plug 'vim-scripts/AutoClose'
  Plug 'francoiscabrol/ranger.vim'
    let g:ranger_replace_netrw = 1
    let g:ranger_map_keys = 0
    map <leader>f :RangerWorkingDirectory<CR>
  Plug 'mattn/emmet-vim' " div.aa<C-y>,  -> <div class=aa>
  Plug 'bkad/CamelCaseMotion'
    let g:camelcasemotion_key = '<leader>'

call plug#end()



" ------------------coc
"
"
  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

