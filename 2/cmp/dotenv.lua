return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "SergioRibera/cmp-dotenv",
  },
  opts = function(_, opts)
    table.insert(opts.sources, { name = "dotenv", group_index = 2 })
  end,
}
