.PHONY: test
test:
	nvim --noplugin -u test/minimal.vim -c "lua require(\"changes\").setup()"
