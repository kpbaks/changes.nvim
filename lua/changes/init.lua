local utils = require("changes.utils")
local cmd = vim.cmd

local M = {}
M.opts = {}
local CHANGES_MAX_ROW_NUM = 100

local hl_group = "HighlightChanges"

M.get_changes = function(history_depth)
	local changes = vim.fn["changes#get_changes#get_changes"]()
	local lines = vim.split(changes, "\n")
	-- remove first line with headers and
	-- remove last line with prompt
	lines = utils.table.slice(lines, 2, #lines - 1)
	if #lines > history_depth then
		lines = utils.table.slice(lines, history_depth) -- get only needed
	end
	local rows = {}
	for _, line in ipairs(lines) do
		local change, line, col, text = string.match(line, "(%d+)%s+(%d+)%s+(%d+)%s+(.+)")
		local row = { change, line, col, text }
		if not vim.tbl_isempty(row) then
			table.insert(rows, row)
		end
	end
	return rows
end

M.highlight_changes = function()
	local changes = M.get_changes(M.opts.number_of_changed_lines_highlighed)
	for _, row in ipairs(changes) do
		local line_nr = tostring(row[2])
		local line = vim.fn.line(line_nr)
		local indentation_offset = utils.get_indentation_offset(line)
		vim.api.nvim_buf_add_highlight(0, M.ns_id, hl_group, line_nr - 1, indentation_offset - 1, -1)
	end
end

M.clear_changes = function(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr or 0, M.ns_id, 0, -1)
end

M.enable = function(cur_buf)
	print(2)
end

M.disable = function(cur_buf) end
M.toggle = function(cur_buf) end

M.setup_buffer_autocmds = function()
    if not M.opts.enable then return end
	local ft = vim.opt.filetype:get()
	if vim.tbl_contains(M.opts.exclude_filetypes,ft) then return end

	for _, event in pairs(M.opts.update_on_events) do
		cmd("autocmd " .. event .. " <buffer> lua require('changes').highlight_changes()")
	end
end

M.setup = function(opts)
	-- stylua: ignore
	local defaults = {
		color                              = vim.opt.background:get() == "dark" and "#3A3A3A" or "#C1C1C1",
		easing_function                    = "none", -- one of "linear", "easein", "easeout", "easeinout", "none"
		enable                             = true,
		exclude_filetypes                  = { "diff", "NvimTree" },
		number_of_changed_lines_highlighed = 10,
		term_color                         = not vim.opt.termguicolors:get() and 208 or nil,
		update_on_events = { "BufEnter", "TextChanged", "InsertEnter", "InsertLeave" },
	}
	local opts = vim.tbl_extend("force", defaults, (opts or {}))
    -- _G.dump(opts)
	M.opts = opts
	M.ns_id = vim.api.nvim_create_namespace("changes.nvim")
	vim.cmd("silent highlight " .. hl_group .. " guibg=" .. M.opts.color)
	-- vim.cmd("silent highlight " .. hl_group .. " guibg=" .. "green")
	vim.cmd[[
		augroup changes_nvim
			autocmd!
			autocmd FileType * lua require("changes").setup_buffer_autocmds()
		augroup END
	]]
end

return M
