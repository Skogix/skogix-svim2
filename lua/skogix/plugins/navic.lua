
	-- Shows your current code context in winbar/statusline
	return {
		'SmiteshP/nvim-navic',
		keys = {
			{
				'<Leader>uB',
				function()
					if vim.b.navic_winbar then
						vim.b['navic_winbar'] = false
						vim.opt_local.winbar = ''
					else
						vim.b['navic_winbar'] = true
						vim.opt_local.winbar = '%#NavicIconsFile# %t %* '
							.. "%{%v:lua.require'nvim-navic'.get_location()%}"
					end
				end,
				desc = 'Breadcrumbs toggle',
			},
		},
		init = function()
			vim.g.navic_silence = true
			LazyVim.lsp.on_attach(function(client, buffer)
				if client.supports_method('textDocument/documentSymbol') then
					require('nvim-navic').attach(client, buffer)
				end
			end)
		end,
		opts = function()
			return {
				separator = '  ',
				highlight = true,
				depth_limit = 5,
				icons = require('lazyvim.config').icons.kinds,
				lazy_update_context = true,
			}
		end,
	}
