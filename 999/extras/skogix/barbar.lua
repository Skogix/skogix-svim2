local bindings = require('skogix.keymaps.barbar')
return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	enabled = true,
	init = function()
		vim.g.barbar_auto_setup = true
	end,
  keys = bindings,
	opts = {
		animation = true,
	}
}
