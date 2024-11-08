require("lazy-bootstrap")

require("lazy").setup({
    require("config/cmp"),
    require("config/lsp"),
    require("config/clang-format"),
    require("config/autoclose"),
    require("config/black"),
    require("config/zig-fmt"),
}, opts)
