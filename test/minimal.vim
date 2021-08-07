set hidden
set noswapfile
set number
set termguicolors
set expandtab
set tabstop=4

set rtp=$VIMRUNTIME
set rtp+=../changes.nvim

lua << EOF
function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end
EOF

