command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>
command! -bang -bar -nargs=* Gpull execute 'Dispatch<bang> -dir=' .
      \ fnameescape(getcwd()) 'git pull' <q-args>
