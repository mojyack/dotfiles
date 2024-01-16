local function config()
    keymap({"n", "v"}, "<leader>lf", ":Black<CR>")
end

return {
    "psf/black",
    ft = {"python"},
    config = config,
}
