local clangd_command = {
    "clangd",
    "--clang-tidy",
    "--header-insertion=never",
}

local clangd_markers = {
    "Makefile",
    "configure.ac",
    "configure.in",
    "config.h.in",
    "meson.build",
    "meson_options.txt",
    "build.ninja",
    "compile_commands.json",
    "compile_flags.txt",
}

local zls_command = {
    "zls",
}

local zls_markers = {
    "build.zig",
}

local function on_attach(client, bufnr)
    local function keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr})
    end

    keymap("n", "<leader>ld", vim.lsp.buf.definition)
    keymap("n", "<leader>lD", vim.lsp.buf.declaration)
    keymap("n", "<leader>ll", vim.lsp.buf.hover)
    keymap("n", "<leader>lt", vim.lsp.buf.type_definition)
    keymap("n", "<leader>lr", vim.lsp.buf.rename)
    keymap("n", "<leader>la", vim.lsp.buf.code_action)
    keymap("n", "<leader>lc", "<cmd>ClangdSwitchSourceHeader<cr>")

    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
    keymap("i", "<C-l>", function() vim.lsp.completion.get() end)
end

vim.lsp.config.clangd = {
    filetypes = {"c", "cpp", "objc", "objcpp"},
    cmd = clangd_command,
    root_markers = clangd_markers,
    on_attach = on_attach,
}

vim.lsp.config.zls = {
    filetypes = {"zig"},
    cmd = zls_command,
    root_markers = zls_markers,
    on_attach = on_attach,
}

vim.lsp.enable({"clangd", "zls"})
