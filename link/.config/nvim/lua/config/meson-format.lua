local filetypes = {"meson"}

local function format()
    --vim.api.nvim_command("write")
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    --local path = vim.api.nvim_buf_get_name(0)
    local result = vim.system({"meson", "format", "-"}, {stdin = lines}):wait()
    if result.code == 0 then
        local stripped = string.gsub(result.stdout, '\n*$', '')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(stripped, "\n"))
    else
        print(("meson format failed code=%d stdout=%s stderr=%s"):format(result.code, result.stdout, result.stderr))
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function(ev)
        vim.keymap.set({"n", "v"}, "<leader>lf", format, { noremap = true, silent = true, buffer = ev.buf })
    end,
})

