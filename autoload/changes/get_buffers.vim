function!s:GetBuffersList()
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction

function! changes#get_buffers#get_buffers() abort
	let buffers_list = s:GetBuffersList()
	return buffers_list
endfunction
