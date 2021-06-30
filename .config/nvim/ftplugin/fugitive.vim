nmap <buffer> <silent> gg ggj
nmap <buffer> <silent> <nowait> j <C-n>
nmap <buffer> <silent> <nowait> k <C-p>
" h to stage/reset
nmap <buffer> <silent> <nowait> h -

augroup ft_gitcommit_status
	autocmd BufEnter <buffer> call <SID>select_first()
augroup END

let s:selected = 0
function! s:select_first()
	setlocal cursorline
	if !s:selected
		" Only once this script is sourced
		" Go to the first file
		" This picks up the horizontal shortcuts already
		execute 'normal' "gg"
		let s:selected = 1
	endif
endfunction
