-- basic options
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.encoding = "utf-8"
vim.o.clipboard = "unnamedplus"
vim.o.nowrap = true

-- basic keybinds
vim.g.mapleader = " "

function keymap(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts and opts or { noremap = true, silent = true })
end
keymap("i", "jk", "<ESC>")
keymap("n", ";", ":", { noremap = true, silent = false })
keymap("n", "<S-h>", "^")
keymap("n", "<S-j>", "}")
keymap("n", "<S-k>", "{")
keymap("n", "<S-l>", "$")
keymap("n", "<C-l>", ":tabnext<CR>")
keymap("n", "<C-h>", ":tabprevious<CR>")
keymap("n", "<C-PageDown>", ":+tabmove<CR>")
keymap("n", "<C-PageUp>", ":-tabmove<CR>")

-- appearance
vim.o.termguicolors = true
vim.g.hybrid_custom_term_colors = 1
vim.g.hybrid_reduced_contrast = 1
vim.cmd("colorscheme hybrid")

-- extra
vim.g.python3_host_prog = "/usr/bin/python3"

require("plugins")
