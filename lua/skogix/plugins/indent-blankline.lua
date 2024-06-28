
	-- Visually display indent levels
	return {
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		event = 'LazyFile',
		keys = {
			{ '<Leader>ue', '<cmd>IBLToggle<CR>', desc = 'Toggle indent-lines' },
		},
		opts = {
			indent = {
				-- See more characters at :h ibl.config.indent.char
				char = '│', -- ▏│
				tab_char = '│',
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					'alpha',
					'checkhealth',
					'dashboard',
					'git',
					'gitcommit',
					'help',
					'lazy',
					'lazyterm',
					'lspinfo',
					'man',
					'mason',
					'neo-tree',
					'notify',
					'Outline',
					'TelescopePrompt',
					'TelescopeResults',
					'terminal',
					'toggleterm',
					'Trouble',
				},
			},
		},
	}
