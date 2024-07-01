local bindings = require('skogix.keymaps.zen-mode')
return {
  -- add zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
    keys = bindings,
  },
}
