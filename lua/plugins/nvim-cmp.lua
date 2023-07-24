local cmp = require("cmp")

return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    opts.mapping["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    opts.mapping["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
  end,
}
