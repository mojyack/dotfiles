-- local function zig_fmt()
--     local view = vim.fn.winsaveview()
--     if vim.fn.executable("zig") ~= 1 then
--         errro("zig executable not found")
--         return
--     end
--     local buf = vim.api.nvim_get_current_buf()
--     local out = vim.fn.systemlist("zig fmt --stdin", buf)
--     if vim.v.shell_error ~= 0 then
--         error("format failed")
--         return
--     end
--     vim.cmd("undojoin")
--     vim.fn.deletebufline(buf, 1, vim.fn.line("$"))
--     vim.fn.setbufline(buf, 1, out)
--     vim.fn.winrestview(view)
-- end

local function config()
    vim.g.zig_fmt_autosave = 0
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "zig",
        callback = function(ev)
            vim.keymap.set({"n", "v"}, "<leader>lf", vim.fn["zig#fmt#Format"], { noremap = true, silent = true, buffer = ev.buf })
        end,
    })
end

return {
    dir = "config/zig-fmt",
    ft = {"zig"},
    config = config,
}
