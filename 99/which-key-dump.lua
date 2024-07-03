local wk = require('which-key')
local Util = require('skogix.util')

wk.register({--add
	p = { "p:let @+=@0<CR>:let @\"=@0<CR>", "Paste" },
	P = { "P:let @+=@0<CR>:let @\"=@0<CR>", "Paste In-place" },
}, { mode = "x" })

-- Telescope
local picker = require('telescope.pickers')
local telescope = require('telescope')
local normal = {
	[']'] = { name = 'next',
-- map('n', ']d', vim.diagnostic.goto_next, { 'Go to next [D]iagnostic message' })
		["]a"] = { "<cmd>lnext<CR>", "Next Loclist" },
		["]b"] = { "<cmd>bnext<CR>", "Next Buffer" },
		["]q"] = { vim.cmd.cnext, "Next Quickfix" },
	},
	['['] = { name = 'prev',
-- map('n', '[d', vim.diagnostic.goto_prev, { 'Go to previous [D]iagnostic message' })
		["[b"] = { "<cmd>bprev<CR>", "Previous Buffer" },
		["[a"] = { "<cmd>lprev<CR>", "Previous Loclist" },
		["[q"] = { vim.cmd.cprev, "Previous Quickfix" },
	},
	s = { -- {{{ s
		name = "[search]",
		[';'] = { "<cmd>Telescope commands<cr>", '[search] commands' },
		['/'] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", '[search] buffer' },
		['<'] = { "<cmd>Telescope search_history<cr>", '[search] history' },
		[':'] = { "<cmd>Telescope command_history<cr>", '[search] command history' },
		['D'] = { '<cmd>Telescope diagnostics<CR>', '[search] workspace diagnostics' },
		['H'] = { '<cmd>Telescope help_tags<CR>', '[search] help pages' },
		['M'] = { '<cmd>Telescope man_pages<CR>', '[search] man pages' },
		['O'] = { "<cmd>Telescope oldfiles<cr>", '[search] old files' },
		['W'] = { '<cmd>Telescope grep_string<CR>', '[search] current word' },
		['b'] = { "<cmd>Telescope buffers<cr>", '[search] buffers' },
		['c'] = { '<cmd>Telescope colorscheme<CR>', '[search] colorscheme' },
		['d'] = { '<cmd>Telescope diagnostics bufnr=0<CR>', '[search] document diagnostics' },
		['g'] = { "<cmd>Telescope live_grep<cr>", '[search] grep' },
		['h'] = { "<cmd>Telescope highlights<cr>", '[search] highlights' },
		['j'] = { "<cmd>Telescope jumplist<cr>", '[search] jumplist' },
		['k'] = { '<cmd>Telescope keymaps<CR>', '[search] key maps' },
		l = {
			name = "[search lsp]",
			['a'] = { '<cmd>Telescope lsp_code_actions<CR>', '[search lsp] code actions' },
			['b'] = { '<cmd>Telescope lsp_range_code_actions<CR>', '[search lsp] code actions' },
			['d'] = { '<cmd>Telescope lsp_definitions<CR>', '[search lsp] definitions' },
			['i'] = { '<cmd>Telescope lsp_implementations<CR>', '[search lsp] implementations' },
			['r'] = { '<cmd>Telescope lsp_references<CR>', '[search lsp] references' },
		},
		['L'] = { '<cmd>Telescope loclist<cr>', '[search] location list' },
		['m'] = { "<cmd>Telescope marks<cr>", '[search] marks' },
		['o'] = { "<cmd>Telescope vim_options<cr>", '[search] neovim options' },
		['p'] = { "<cmd>Telescope pickers<cr>", '[search] pickers' },
		['q'] = { '<cmd>Telescope quickfix<cr>', '[search] quickfix list' },
		['r'] = { "<cmd>Telescope registers<cr>", '[search] registers' },
		['s'] = { "<cmd>Telescope git_files<cr>", '[search] files' },
		['S'] = { "<cmd>Telescope find_files<cr>", '[search] files' },
		['w'] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", '[search] workspace symbols' },
	}, -- }}}
}

-- Diagnostic keymaps
-- map('n', '<leader>e', vim.diagnostic.open_float, { 'Show diagnostic [E]rror messages' })
-- map('n', '<leader>q', vim.diagnostic.setloclist, { 'Open diagnostic [Q]uickfix list' })
local leader = {
	a = { -- {{{ a
		name = 'ai',
		['a'] = {
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end,
			"CopilotChat - Quick chat",
		},
	}, -- }}}
	b = { name = 'buffer' },
	c = { -- {{{ c
		name = 'code',
		f = { function() LazyVim.format({ force = true }) end, "Format" },
		i = { "<cmd>LazyFormatInfo<CR>", "Formatter Info" },
	}, -- }}}
	f = { name = 'file/find' },
	h = { name = 'harpoon' },
	m = { name = 'tools' },
	n = { name = 'notes' },
	t = { -- {{{ t
		name = 'term',
		t = { lazyterm, '[term] root' },
		T = {function() LazyVim.terminal() end, '[term] cwd' },
		cd = { function()
			local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
			if bufdir ~= nil and vim.uv.fs_stat(bufdir) then
				vim.cmd.tcd(bufdir)
				vim.notify(bufdir)
			end
		end, "Change Tab Directory" },
		a = { function()
			if vim.bo.filetype ~= 'qf' then
				vim.diagnostic.setloclist({ open = false })
			end
			Util.edit.toggle_list('loclist')
		end, "Open Location List" },
	}, -- }}}
	u = { -- {{{ u
		name = 'ui',
		f = { function() LazyVim.format.toggle() end, "Toggle Auto Format (Global)" },
		F = { function() LazyVim.format.toggle(true) end, "Toggle Auto Format (Buffer)" },
		s = { function() LazyVim.toggle('spell') end, "Toggle Spelling" },
		w = { function() LazyVim.toggle('wrap') end, "Toggle Word Wrap" },
		L = { function() LazyVim.toggle('relativenumber') end, "Toggle Relative Line Numbers" },
		l = { function() LazyVim.toggle.number() end, "Toggle Line Numbers" },
		d = { function() Util.edit.diagnostic_toggle(false) end, "Disable Diagnostics" },
		D = { function() Util.edit.diagnostic_toggle(true) end, "Disable All Diagnostics" },
		o = { "<cmd>setlocal nolist!<CR>", "Toggle Whitespace Symbols" },
		u = { "<cmd>nohl[search]<CR>", "Hide Search Highlight" },
		h = { function() LazyVim.toggle.inlay_hints() end, "Toggle Inlay Hints" },
		T = { function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, "Toggle Treesitter Highlight" },
		b = { function() LazyVim.toggle('background', false, {'light', 'dark'}) end, "Toggle Background" },
	}, -- }}}
	x = { -- {{{ x
		name = 'diagnostics/quickfix',
		l = { function() Util.edit.toggle_list('loclist') end, "Toggle Location List" },
		q = { function() Util.edit.toggle_list('quickfix') end, "Toggle Quickfix List" },
	}, -- }}}
	g = { -- {{{ g
		name = "git",
	}, -- }}}
	i = { vim.show_pos, "Show Treesitter Node" },
	I = { "<cmd>InspectTree<cr>", "Inspect Tree" },
}

local opts = { prefix = "<leader>", mode = 'n' }
wk.register(leader, opts)
wk.register(normal, {mode = 'n'})
