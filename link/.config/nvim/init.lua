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
keymap({"n", "v"}, ";", ":", {} )
keymap({"n", "v"}, "<S-h>", "^")
keymap({"n", "v"}, "<S-j>", "}")
keymap({"n", "v"}, "<S-k>", "{")
keymap({"n", "v"}, "<S-l>", "$")
keymap("n", "<C-l>", ":tabnext<CR>")
keymap("n", "<C-h>", ":tabprevious<CR>")
keymap("n", "<C-PageDown>", ":+tabmove<CR>")
keymap("n", "<C-PageUp>", ":-tabmove<CR>")
-- popup
keymap("i", "<C-j>", "<C-n>")
keymap("i", "<C-k>", "<C-p>")
keymap("i", "<Tab>", function() return vim.fn.pumvisible() == 1 and "<C-n><C-y>" or "<Tab>" end, { expr = true, silent = true })

-- appearance
vim.opt.termguicolors = true
vim.cmd("colorscheme habamax")
vim.cmd("hi Normal guibg=#232C31")
-- vim.cmd("hi Visual guifg=NONE guibg=#425059")
vim.cmd("hi MatchParen guifg=#F0C674 guibg=#6C7A80")
vim.cmd("hi @lsp.type.function.cpp guifg=#8C9440")

-- extra
vim.g.python3_host_prog = "/usr/bin/python3"

vim.diagnostic.config({
    virtual_lines = { current_line = true }
})

require("plugins")
