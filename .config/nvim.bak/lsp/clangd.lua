return {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never", "--completion-style=detailed", "--fallback-style=llvm" },
    filetypes = { "c", "cpp", "cc", "cxx", "h", "hpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
    init_options = {
        fallbackFlags = { "-std=c++20", "-Wall", "-Wextra" },
    },
}
