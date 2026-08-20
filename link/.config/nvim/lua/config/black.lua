local function config()
    vim.g.black_use_virtualenv = 0
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(ev)
            vim.keymap.set({"n", "v"}, "<leader>lf", ":Black<CR>", { noremap = true, silent = true, buffer = ev.buf })
        end,
    })
end

return {
    "psf/black",
    ft = {"python"},
    config = config,
}
