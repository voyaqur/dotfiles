return {
	signs = {
		add          = { text = "+" }, 
		change       = { text = "┃" }, 
		delete       = { text = "_" }, 
		topdelete    = { text = "‾" }, 
		changedelete = { text = "~" }, 
		untracked    = { text = "┆" }, 
	}, 
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	watch_gitdir = { follow_files = true }, 
	auto_attach = true,
}
