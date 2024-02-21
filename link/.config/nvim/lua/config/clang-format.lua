local filetypes = {"c", "cpp", "objc", "objcpp", "cs", "java", "javascript", "json", "proto"}

local function config()
    vim.g["clang_format#code_style"] = "LLVM"
    vim.g["clang_format#style_options"] = {
        ColumnLimit = "0", 
        BreakBeforeBraces = "Attach",
        SpaceBeforeParens = "Never", 
        PointerAlignment = "Left", 
        AllowShortIfStatementsOnASingleLine = "true",
        AlignConsecutiveAssignments = "true",
        AlignConsecutiveDeclarations = "true",
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(ev)
            vim.keymap.set({"n", "v"}, "<leader>lf", ":ClangFormat<CR>", { noremap = true, silent = true, buffer = ev.buf })
        end,
    })
end

return {
    "rhysd/vim-clang-format",
    ft = filetypes,
    config = config,
}
