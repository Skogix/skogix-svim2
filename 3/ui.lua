return {
	--
	{ 'nvim-tree/nvim-web-devicons',   lazy = false },
	{
		'rafi/theme-loader.nvim',
		lazy = false,
		priority = 99,
		opts = { initial_colorscheme = 'catppuccin' },
	},
	{ 'rafi/awesome-vim-colorschemes', lazy = false },
	{ 'MunifTanjim/nui.nvim',          lazy = false },
	{
		'stevearc/dressing.nvim',
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require('lazy').load({ plugins = { 'dressing.nvim' } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require('lazy').load({ plugins = { 'dressing.nvim' } })
				return vim.ui.input(...)
			end
		end,
	},
	--
	--
	--
	-- -----------------------------------------------------------------------------
	-- -- Fancy notification manager
	{
		'rcarriga/nvim-notify',
		priority = 9000,
		keys = {
			{
				'<leader>un',
				function()
					require('notify').dismiss({ silent = true, pending = true })
				end,
				desc = 'Dismiss All Notifications',
			},
		},
		opts = {
			stages = 'static',
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		init = function()
			-- When noice is not enabled, install notify on VeryLazy
			if not LazyVim.has('noice.nvim') then
				LazyVim.on_very_lazy(function()
					vim.notify = require('notify')
				end)
			end
		end,
	},

	-- -----------------------------------------------------------------------------
	-- -- Snazzy tab/bufferline
	-- -----------------------------------------------------------------------------
	-- -- Helper for removing buffers
	-- {
	-- 	'echasnovski/mini.bufremove',
	-- 	opts = {},
	-- 	-- stylua: ignore
	-- 	keys = {
	-- 		{ '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer', },
	-- 	},
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Replaces the UI for messages, cmdline and the popupmenu
	-- {
	-- 	'folke/noice.nvim',
	-- 	event = 'VeryLazy',
	-- 	enabled = not vim.g.started_by_firenvim,
	-- 	-- stylua: ignore
	-- 	keys = {
	-- 		{ '<S-Enter>', function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c', desc = 'Redirect Cmdline' },
	-- 		{ '<leader>snl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
	-- 		{ '<leader>snh', function() require('noice').cmd('history') end, desc = 'Noice History' },
	-- 		{ '<leader>sna', function() require('noice').cmd('all') end, desc = 'Noice All' },
	-- 		{ '<leader>snt', function() require('noice').cmd('telescope') end, desc = 'Noice Telescope' },
	-- 		{ '<C-f>', function() if not require('noice.lsp').scroll(4) then return '<C-f>' end end, silent = true, expr = true, desc = 'Scroll Forward', mode = {'i', 'n', 's'} },
	-- 		{ '<C-b>', function() if not require('noice.lsp').scroll(-4) then return '<C-b>' end end, silent = true, expr = true, desc = 'Scroll Backward', mode = {'i', 'n', 's'}},
	-- 	},
	-- 	---@type NoiceConfig
	-- 	opts = {
	-- 		lsp = {
	-- 			override = {
	-- 				['vim.lsp.util.convert_input_to_markdown_lines'] = true,
	-- 				['vim.lsp.util.stylize_markdown'] = true,
	-- 				['cmp.entry.get_documentation'] = true,
	-- 			},
	-- 		},
	-- 		messages = {
	-- 			view_search = false,
	-- 		},
	-- 		routes = {
	-- 			-- See :h ui-messages
	-- 			{
	-- 				filter = {
	-- 					event = 'msg_show',
	-- 					any = {
	-- 						{ find = '%d+L, %d+B' },
	-- 						{ find = '^%d+ changes?; after #%d+' },
	-- 						{ find = '^%d+ changes?; before #%d+' },
	-- 						{ find = '^Hunk %d+ of %d+$' },
	-- 						{ find = '^%d+ fewer lines;?' },
	-- 						{ find = '^%d+ more lines?;?' },
	-- 						{ find = '^%d+ line less;?' },
	-- 						{ find = '^Already at newest change' },
	-- 						{ kind = 'wmsg' },
	-- 						{ kind = 'emsg', find = 'E486' },
	-- 						{ kind = 'quickfix' },
	-- 					},
	-- 				},
	-- 				view = 'mini',
	-- 			},
	-- 			{
	-- 				filter = {
	-- 					event = 'msg_show',
	-- 					any = {
	-- 						{ find = '^%d+ lines .ed %d+ times?$' },
	-- 						{ find = '^%d+ lines yanked$' },
	-- 						{ kind = 'emsg', find = 'E490' },
	-- 						{ kind = 'search_count' },
	-- 					},
	-- 				},
	-- 				opts = { skip = true },
	-- 			},
	-- 			{
	-- 				filter = {
	-- 					event = 'notify',
	-- 					any = {
	-- 						{ find = '^No code actions available$' },
	-- 						{ find = '^No information available$' },
	-- 					},
	-- 				},
	-- 				view = 'mini',
	-- 			},
	-- 		},
	-- 		presets = {
	-- 			command_palette = true,
	-- 			long_message_to_split = true,
	-- 			lsp_doc_border = true,
	-- 			-- inc_rename = true,
	-- 		},
	-- 	},
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Shows your current code context in winbar/statusline
	-- {
	-- 	'SmiteshP/nvim-navic',
	-- 	keys = {
	-- 		{
	-- 			'<Leader>uB',
	-- 			function()
	-- 				if vim.b.navic_winbar then
	-- 					vim.b['navic_winbar'] = false
	-- 					vim.opt_local.winbar = ''
	-- 				else
	-- 					vim.b['navic_winbar'] = true
	-- 					vim.opt_local.winbar = '%#NavicIconsFile# %t %* '
	-- 						.. "%{%v:lua.require'nvim-navic'.get_location()%}"
	-- 				end
	-- 			end,
	-- 			desc = 'Breadcrumbs toggle',
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		vim.g.navic_silence = true
	-- 		LazyVim.lsp.on_attach(function(client, buffer)
	-- 			if client.supports_method('textDocument/documentSymbol') then
	-- 				require('nvim-navic').attach(client, buffer)
	-- 			end
	-- 		end)
	-- 	end,
	-- 	opts = function()
	-- 		return {
	-- 			separator = '  ',
	-- 			highlight = true,
	-- 			depth_limit = 5,
	-- 			icons = require('lazyvim.config').icons.kinds,
	-- 			lazy_update_context = true,
	-- 		}
	-- 	end,
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Interacting with and manipulating marks
	-- {
	-- 	'chentoast/marks.nvim',
	-- 	event = 'FileType',
	-- 	keys = {
	-- 		{ 'm/', '<cmd>MarksListAll<CR>', desc = 'Marks from all opened buffers' },
	-- 	},
	-- 	opts = {
	-- 		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	-- 		bookmark_1 = { sign = '󰈼' }, -- ⚐ ⚑ 󰈻 󰈼 󰈽 󰈾 󰈿 󰉀
	-- 		mappings = {
	-- 			annotate = 'm<Space>',
	-- 		},
	-- 	},
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Visually display indent levels
	-- {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	main = 'ibl',
	-- 	event = 'LazyFile',
	-- 	keys = {
	-- 		{ '<Leader>ue', '<cmd>IBLToggle<CR>', desc = 'Toggle indent-lines' },
	-- 	},
	-- 	opts = {
	-- 		indent = {
	-- 			-- See more characters at :h ibl.config.indent.char
	-- 			char = '│', -- ▏│
	-- 			tab_char = '│',
	-- 		},
	-- 		scope = { enabled = false },
	-- 		exclude = {
	-- 			filetypes = {
	-- 				'alpha',
	-- 				'checkhealth',
	-- 				'dashboard',
	-- 				'git',
	-- 				'gitcommit',
	-- 				'help',
	-- 				'lazy',
	-- 				'lazyterm',
	-- 				'lspinfo',
	-- 				'man',
	-- 				'mason',
	-- 				'neo-tree',
	-- 				'notify',
	-- 				'Outline',
	-- 				'TelescopePrompt',
	-- 				'TelescopeResults',
	-- 				'terminal',
	-- 				'toggleterm',
	-- 				'Trouble',
	-- 			},
	-- 		},
	-- 	},
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Visualize and operate on indent scope
	-- {
	-- 	'echasnovski/mini.indentscope',
	-- 	event = 'LazyFile',
	-- 	opts = function(_, opts)
	-- 		opts.symbol = '│' -- ▏│
	-- 		opts.options = { try_as_border = true }
	-- 		opts.draw = {
	-- 			delay = 0,
	-- 			animation = require('mini.indentscope').gen_animation.none(),
	-- 		}
	-- 	end,
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd('FileType', {
	-- 			pattern = {
	-- 				'alpha',
	-- 				'dashboard',
	-- 				'help',
	-- 				'lazy',
	-- 				'lazyterm',
	-- 				'man',
	-- 				'mason',
	-- 				'neo-tree',
	-- 				'notify',
	-- 				'Outline',
	-- 				'toggleterm',
	-- 				'Trouble',
	-- 			},
	-- 			callback = function()
	-- 				vim.b['miniindentscope_disable'] = true
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Create key bindings that stick
	-- {
	-- 	'folke/which-key.nvim',
	-- 	event = 'VeryLazy',
	-- 	-- stylua: ignore
	-- 	opts = {
	-- 		icons = {
	-- 			separator = ' 󰁔 ',
	-- 		},
	-- 		defaults = {
	-- 			mode = { 'n', 'v' },
	-- 			[';'] = { name = '+telescope' },
	-- 			[';d'] = { name = '+lsp' },
	-- 			['g'] = { name = '+goto' },
	-- 			['gz'] = { name = '+surround' },
	-- 			[']'] = { name = '+next' },
	-- 			['['] = { name = '+prev' },
	--
	-- 			['<leader>b']  = { name = '+buffer' },
	-- 			['<leader>c']  = { name = '+code' },
	-- 			['<leader>ch'] = { name = '+calls' },
	-- 			['<leader>f']  = { name = '+file/find' },
	-- 			['<leader>fw'] = { name = '+workspace' },
	-- 			['<leader>g']  = { name = '+git' },
	-- 			['<leader>h']  = { name = '+hunks' },
	-- 			['<leader>ht'] = { name = '+toggle' },
	-- 			['<leader>m']  = { name = '+tools' },
	-- 			['<leader>md'] = { name = '+diff' },
	-- 			['<leader>s']  = { name = '+search' },
	-- 			['<leader>sn'] = { name = '+noice' },
	-- 			['<leader>t']  = { name = '+toggle/tools' },
	-- 			['<leader>u']  = { name = '+ui' },
	-- 			['<leader>x']  = { name = '+diagnostics/quickfix' },
	-- 			['<leader>z']  = { name = '+notes' },
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		local wk = require('which-key')
	-- 		wk.setup(opts)
	-- 		wk.register(opts.defaults)
	-- 	end,
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Hint and fix deviating indentation
	-- {
	-- 	'tenxsoydev/tabs-vs-spaces.nvim',
	-- 	event = { 'BufReadPost', 'BufNewFile' },
	-- 	opts = {},
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Highlight words quickly
	-- {
	-- 	't9md/vim-quickhl',
	-- 	keys = {
	-- 		{
	-- 			'<Leader>mt',
	-- 			'<Plug>(quickhl-manual-this)',
	-- 			mode = { 'n', 'x' },
	-- 			desc = 'Highlight word',
	-- 		},
	-- 	},
	-- },
	--
	-- -----------------------------------------------------------------------------
	-- -- Better quickfix window
	-- {
	-- 	'kevinhwang91/nvim-bqf',
	-- 	ft = 'qf',
	-- 	cmd = 'BqfAutoToggle',
	-- 	event = 'QuickFixCmdPost',
	-- 	opts = {
	-- 		auto_resize_height = false,
	-- 		func_map = {
	-- 			tab = 'st',
	-- 			split = 'sv',
	-- 			vsplit = 'sg',
	--
	-- 			stoggleup = 'K',
	-- 			stoggledown = 'J',
	--
	-- 			ptoggleitem = 'p',
	-- 			ptoggleauto = 'P',
	-- 			ptogglemode = 'zp',
	--
	-- 			pscrollup = '<C-b>',
	-- 			pscrolldown = '<C-f>',
	--
	-- 			prevfile = 'gk',
	-- 			nextfile = 'gj',
	--
	-- 			prevhist = '<S-Tab>',
	-- 			nexthist = '<Tab>',
	-- 		},
	-- 		preview = {
	-- 			auto_preview = true,
	-- 			should_preview_cb = function(bufnr)
	-- 				-- file size greater than 100kb can't be previewed automatically
	-- 				local filename = vim.api.nvim_buf_get_name(bufnr)
	-- 				local fsize = vim.fn.getfsize(filename)
	-- 				if fsize > 100 * 1024 then
	-- 					return false
	-- 				end
	-- 				return true
	-- 			end,
	-- 		},
	-- 	},
	-- },
}
