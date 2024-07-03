return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "lukas-reineke/cmp-under-comparator",
  },
  opts = function(_, opts)
    -- table.insert(opts.sorting.comparators, 4, require("cmp-under-comparator").under)
    table.insert(opts.sources, { name = "cmp_under_comparator" })
  end,
}
