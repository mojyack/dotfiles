local function config()
    require("hex").setup {
        is_file_binary_post_read = function()
            return false
        end,
    }
end

return {
    "RaafatTurki/hex.nvim",
    config = config,
}
