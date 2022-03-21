local cmd = vim.cmd
local M = {}

M.table = {}

M.table.slice = function(tbl, first, last, step)
	local sliced = {}

	for i = first or 1, last or #tbl, step or 1 do
		sliced[#sliced + 1] = tbl[i]
	end

	return sliced
end

M.get_indentation_offset = function(line)
	local start, _end = string.find(line, "[^\t%s]")
	if start == nil and _end == nil then
		return ""
	else
		return _end
	end
end

M.get_buffer_nums = function()
	local res = {}
	for b = 0, vim.fn.bufnr("$") do
		if vim.fn.buflisted(b) then
			table.insert(res, b)
		end
	end
	return res
end

function M.create_augroup(name, autocmds)
	cmd("augroup " .. name)
	cmd("autocmd!")
	for _, autocmd in ipairs(autocmds) do
		cmd("autocmd " .. table.concat(autocmd, " "))
	end
	cmd("augroup END")
end

return M
