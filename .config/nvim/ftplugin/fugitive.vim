nmap <buffer> <silent> <nowait> l -
nmap <buffer> <silent> <nowait> h =
nnoremap <buffer> <silent> cc :Git commit --quiet<CR>
nnoremap <buffer> <silent> ca :Git commit --quiet --amend<CR>
nnoremap <buffer> <silent> ce :Git commit --quiet --amend --no-edit<CR>



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
		execute 'normal' "<C-n>"
		let s:selected = 1
	endif
endfunction
