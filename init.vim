syntax enable 
filetype plugin indent on
" search down subfolders in :find completion, but ignore node_modules
set path+=** wildignore+=**/node_modules/**
set rnu nu tabstop=2 shiftwidth=2 expandtab nocompatible smartcase wildmenu noswapfile

nnoremap <C-l> :Lex .<CR>
map <Esc><Esc> :w<CR>

" open git commit in insert mode
autocmd FileType gitcommit exec 'au VimEnter * startinsert'


let g:camelcasemotion_key = '<leader>'
" netrw
  " https://shapeshed.com/vim-netrw/
  let g:netrw_liststyle = 3 " tree view (expandable folders)
  let g:netrw_banner = 0 " remove tips at top
  let g:netrw_browse_split = 2 " open entered file to side split rather than replacing netrw split
  " netrw line numbers https://stackoverflow.com/a/8731175/10706046
  let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

call plug#begin()
Plug 'vim-scripts/AutoClose'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-vetur'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"
" syntax highl.
Plug 'posva/vim-vue'
call plug#end()

"posva vim-vue
let g:vue_pre_processors = ['typescript', 'scss']

" coc
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

:map <C-p> :FZF<CR>
