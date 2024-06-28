local neogeo_opts = {}

if not vim.g.vscode then
  neogeo_opts = {
    enabled = true,
    -- Only use luasnip as snippet engine if that is not vscode
    snippet_engine = "luasnip",
  }
end

return {
  {
    -- A better annotation generator. Supports multiple languages and annotation conventions.
    -- <C-n> to jump to next annotation, <C-p> to jump to previous annotation
    "danymat/neogen",
    vscode = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = neogeo_opts,
    cmd = "Neogen",
    keys = {
      { "<leader>ci", "<cmd>Neogen<cr>", desc = "Neogen - Annotation generator" },
    },
  },
}
