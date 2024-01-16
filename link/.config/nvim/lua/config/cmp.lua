local function config()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local opts = {
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<S-Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
        }, {
            { name = "buffer" },
        }),
        experimental = {
            ghost_text = {
                hl_group = "CmpGhostText",
            },
        },
        sorting = defaults.sorting,
    }

    for _, source in ipairs(opts.sources) do
          source.group_index = source.group_index or 1
    end

    require("cmp").setup(opts)
end

return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
    },
    config = config,
}
