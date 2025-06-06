require("lazy-bootstrap")

require("config/zig-fmt")
require("config/lsp")
require("lazy").setup({
    require("config/clang-format"),
    require("config/autoclose"),
    require("config/black"),
}, opts)
