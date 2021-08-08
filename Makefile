.PHONY: test
test:
	nvim --noplugin -u test/minimal.vim -c "lua require(\"changes\").setup()"

.PHONY: live-test
live-test:
	nvim -c "set rtp+=/home/kristoffer/git-repositories/projects/changes.nvim | lua require(\"changes\").setup()"
	# nvim -c "set rtp+=../changes.nvim"
