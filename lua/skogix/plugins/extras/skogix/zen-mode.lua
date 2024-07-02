local bindings = require('skogix.keymaps.zen-mode')
return {
  -- add zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = { enabled = true },
				tmux = { enabled = vim.env.TMUX ~= nil },
			},
		},
    keys = bindings,
  },
}
