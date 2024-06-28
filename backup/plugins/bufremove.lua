	-- Helper for removing buffers
	return {
		'echasnovski/mini.bufremove',
		opts = {},
		-- stylua: ignore
		keys = {
			{ '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer', },
		},
	}
