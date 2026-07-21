return {
	cmd = {
		"clangd",
		"--background-index=false",    -- Disables heavy background indexing for speed on single-file solves
		"--header-insertion=never",    -- Prevents auto-adding #include directives when picking autocompletions
		"--completion-style=detailed",
		"--function-arg-placeholders=0", -- Stops inserting dummy arg placeholders into templates/functions
		"--clang-tidy=false",          -- Turns off linter checks (saves CPU; useless for speed coding)
		"--fallback-style=llvm",
		"-j=4",                        -- Allocates 4 worker threads for fast local parsing
	},
	filetypes = { "cpp", "c" },
	root_markers = {
		".clangd",
		"compile_commands.json",
		".git",
	},
	init_options = {
		usePlaceholders = false,
		completeUnimported = false, -- Won't suggest unimported headers (keeps suggestions relevant)
		clangdFileStatus = false,
	},
}
