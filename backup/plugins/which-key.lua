	return {
		'folke/which-key.nvim',
		event = 'VeryLazy',
		-- stylua: ignore
		opts = {
			icons = {
				separator = ' 󰁔 ',
			},
			defaults = {
				mode = { 'n', 'v' },
				['s'] = { name = '+telescope' },
				-- [';d'] = { name = '+lsp' },
				-- ['g'] = { name = '+goto' },
				-- ['gz'] = { name = '+surround' },
				-- [']'] = { name = '+next' },
				-- ['['] = { name = '+prev' },
				--
				-- ['<leader>b']  = { name = '+buffer' },
				['<leader>c']  = { name = '+code' },
				-- ['<leader>ch'] = { name = '+calls' },
				-- ['<leader>f']  = { name = '+file/find' },
				-- ['<leader>fw'] = { name = '+workspace' },
				['<leader>g']  = { name = '+git' },
				['<leader>h']  = { name = '+harpoon' },
				-- ['<leader>ht'] = { name = '+toggle' },
				-- ['<leader>m']  = { name = '+tools' },
				-- ['<leader>md'] = { name = '+diff' },
				['<leader>s']  = { name = '+search' },
				-- ['<leader>sn'] = { name = '+noice' },
				-- ['<leader>t']  = { name = '+toggle/tools' },
				-- ['<leader>u']  = { name = '+ui' },
				-- ['<leader>x']  = { name = '+diagnostics/quickfix' },
				-- ['<leader>z']  = { name = '+notes' },
			},
		},
		config = function(_, opts)
			local wk = require('which-key')
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	}
