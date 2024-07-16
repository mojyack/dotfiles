-- basic options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false

-- basic keybinds
vim.g.mapleader = " "

function keymap(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts and opts or { noremap = true, silent = true })
end
keymap("i", "jk", "<ESC>")
keymap({"n", "v"}, ";", ":", { noremap = true, silent = false })
keymap({"n", "v"}, "<S-h>", "^")
keymap({"n", "v"}, "<S-j>", "}")
keymap({"n", "v"}, "<S-k>", "{")
keymap({"n", "v"}, "<S-l>", "$")
keymap("n", "<C-l>", ":tabnext<CR>")
keymap("n", "<C-h>", ":tabprevious<CR>")
keymap("n", "<C-PageDown>", ":+tabmove<CR>")
keymap("n", "<C-PageUp>", ":-tabmove<CR>")

-- appearance
vim.opt.termguicolors = true
vim.g.hybrid_custom_term_colors = 1
vim.g.hybrid_reduced_contrast = 1
vim.cmd("colorscheme hybrid")

-- extra
vim.g.python3_host_prog = "/usr/bin/python3"

require("plugins")
