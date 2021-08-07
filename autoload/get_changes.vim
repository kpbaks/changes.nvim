function! g:get_changes() abort
	let res = ""
	set nomore
	redir => res
	" change line col text
	changes
	redir END
	set more
	return res
endfunction
