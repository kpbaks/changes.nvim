local M = {}
function table.slice(tbl, first, last, step)
	local sliced = {}

	for i = first or 1, last or #tbl, step or 1 do
		sliced[#sliced + 1] = tbl[i]
	end

	return sliced
end
M.get_changes = function(history_depth)
	local changes = vim.api.nvim_call_function("g:get_changes()", {})
	local lines = vim.split(changes, "\n")
	-- remove first line with headers and
	-- remove last line with prompt
	lines = table.slice(lines, 2, #lines - 1)
	if #lines > history_depth then
		lines = table.slice(lines, history_depth)
	end
	local line_nums = {}
	for _, line in ipairs(lines) do
		local line_split = vim.split(line)
		table.insert(line_nums, line_split)
	end
	return line_nums
end

return M
