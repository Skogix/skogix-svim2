return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	-- stylua: ignore
	opts = {
		icons = {
			separator = ' 󰁔 ',
		}
	},
	config = function(_, opts)
		local wk = require('which-key')
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
