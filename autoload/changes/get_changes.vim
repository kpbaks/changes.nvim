function! s:GetChangesList() abort
	let res = ""
	set nomore
	redir => res
	" change line col text
	silent
	changes
	redir END
	set more
	return res
endfunction

function! changes#get_changes#get_changes() abort
	silent let changes_list = s:GetChangesList()
	return changes_list
endfunction
