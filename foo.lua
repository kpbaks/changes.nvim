local exclude_filetypes = { "la", "diff", "NvimTree" }
local ft = vim.opt.filetype:get()
print(ft)
print(vim.tbl_contains(exclude_filetypes, ft))
