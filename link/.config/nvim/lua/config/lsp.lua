local function find_project_root(path)
    local util = require("lspconfig.util")
    local markers = {
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja",
    }
    local markers_second = {
        "compile_commands.json",
        "compile_flags.txt",
    }
    return util.root_pattern(unpack(markers))(path) or
           util.root_pattern(unpack(markers_second))(path) or
           util.find_git_ancestor(path)
end

local clangd_command = {
    "clangd",
    "--clang-tidy",
    "--header-insertion=never",
}

local function on_attach(client, bufnr)
    local function keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr})
    end
    keymap("n", "<leader>ld", vim.lsp.buf.declaration)
    keymap("n", "<leader>lc", "<cmd>ClangdSwitchSourceHeader<cr>")
end

local function config()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    lspconfig["clangd"].setup({
        capabilities = capabilities,
        filetypes = {"c", "cpp", "objc", "objcpp"},
        cmd = clangd_command,
        root_dir = find_project_root,
        on_attach = on_attach,
    })
end

return {
    "neovim/nvim-lspconfig",
    ft = {"c", "cpp", "objc", "objcpp"},
    config = config,
}
