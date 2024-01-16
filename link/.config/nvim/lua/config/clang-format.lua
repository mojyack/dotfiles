local function config()
    vim.g["clang_format#style_options"] = {
        BasedOnStyle = "LLVM",
        ColumnLimit = "0", 
        BreakBeforeBraces = "Attach",
        SpaceBeforeParens = "Never", 
        IndentWidth = "4", 
        UseTab = "Never", 
        PointerAlignment = "Left", 
        AllowShortIfStatementsOnASingleLine = "true",
        AlignConsecutiveAssignments = "true",
        AlignConsecutiveDeclarations = "true",
    }

    keymap({"n", "v"}, "<leader>lf", ":ClangFormat<CR>")
end

return {
    "rhysd/vim-clang-format",
    ft = {"c", "cpp", "objc", "objcpp", "cs", "java", "javascript", "json", "proto"},
    config = config,
}
