

return {
  { import = "lazyvim.plugins.extras.coding.neogen" },
  {
    "danymat/neogen",
    -- stylua: ignore

    keys = {
      { "<leader>A", "", desc = " annotation/snippets" },
      { "<leader>AA", function() require("neogen").generate({ type = "any" }) end, desc = "Default Annotation" },
      { "<leader>AC", function() require("neogen").generate({ type = "class" }) end, desc = "Class" },
      { "<leader>Af", function() require("neogen").generate({ type = "func" }) end, desc = "Function" },
      { "<leader>At", function() require("neogen").generate({ type = "type" }) end, desc = "Type" },
      { "<leader>AF", function() require("neogen").generate({ type = "file" }) end, desc = "File" },
    },
  },
  {
    "Zeioth/dooku.nvim",
    cmd = { "DookuGenerate", "DookuOpen", "DookuAutoSetup" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>Ag", "<Cmd>DookuGenerate<CR>", desc = "Generate HTML Docs" },
      { "<leader>Ao", "<Cmd>DookuOpen<CR>", desc = "Open HTML Docs" },
    },
  },
}
