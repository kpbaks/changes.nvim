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

return M
