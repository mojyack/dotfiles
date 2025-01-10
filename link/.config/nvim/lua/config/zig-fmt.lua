vim.g.zig_fmt_autosave = 0
vim.api.nvim_create_autocmd("FileType", {
    pattern = "zig",
    callback = function(ev)
        vim.keymap.set({"n", "v"}, "<leader>lf", vim.fn["zig#fmt#Format"], { noremap = true, silent = true, buffer = ev.buf })
    end,
})
