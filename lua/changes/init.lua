local utils = require("changes.utils")

local M = {}

M.get_changes = function(history_depth)
	local changes = vim.fn["changes#get_changes#get_changes"]()
	-- local changes = vim.api.nvim_call_function("g:get_changes()", {})
	local lines = vim.split(changes, "\n")
	-- remove first line with headers and
	-- remove last line with prompt
	lines = utils.table.slice(lines, 2, #lines - 1)
	if #lines > history_depth then
		lines = utils.table.slice(lines, history_depth) -- get only needed
	end
	local rows = {}
	local i = 0
	for _, line in ipairs(lines) do
		-- local line_split = vim.split(line, " ")
		-- i = i + 1
		local change, line, col, text = string.match(line,"(%d+)%s+(%d+)%s+(%d+)%s+(.+)")
		-- if i == 1 then print(string.format("%s %s %s text: %s", change, line, col, text)) end
		
		--_G.dump({
		--	change = change,
		--	line = line,
		--	col = col,
		--	text = text
		--})
		local row = { change, line, col, text }
		-- line_split = vim.tbl_filter(function(a) return a ~= "" end, line_split)
		table.insert(rows, row)
	end
	return rows
end
print(_G.dump(M.get_changes(54)[1]))
-- print(M.get_changes(2)[1])

-- return M
