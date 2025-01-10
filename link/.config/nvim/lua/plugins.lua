require("lazy-bootstrap")

require("config/zig-fmt")
require("lazy").setup({
    require("config/cmp"),
    require("config/lsp"),
    require("config/clang-format"),
    require("config/autoclose"),
    require("config/black"),
}, opts)
