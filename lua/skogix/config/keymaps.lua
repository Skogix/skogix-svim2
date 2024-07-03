-- Neovim keymaps
-- This file is automatically loaded by skogix.config.init

local util = require('skogix.util.keymaps')
local map = vim.keymap.set


-- skogix/keymaps/neorg.lua
-- require('skogix.keymaps.neorg').globals(wk)

-- {{{ functions
--- }}}
-- {{{ basics
-- Copy paste
map({ 'n', 'x' }, '<leader>y', [["+y]]) -- copy to system clipboard
map({ 'n', 'x' }, '<leader>p', [["+p]]) -- paste from system clipboard
-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Down' })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Up' })

-- Set highlight on [search], but clear on pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.hlsearch = true
-- }}} 
-- {{{ terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Enter Normal Mode' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- }}}
-- {{{ maps
-- Close all fold except the current one.
map("n", "zv", "zMzvzz", {
	desc = "Close all folds except the current one",
})

-- Close current fold when open. Always open next fold.
map("n", "zj", "zcjzOzz", {
	desc = "Close current fold when open. Always open next fold.",
})

-- Close current fold when open. Always open previous fold.
map("n", "zk", "zckzOzz", {
	desc = "Close current fold when open. Always open previous fold.",
})

-- Better paste
-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
map("v", "p", '"_dP', { desc = "" })

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { desc = "" })
map("v", ">", ">gv", { desc = "" })
map('n', ';', ':', { desc = 'command' }) -- ; => :
-- }}}





------------------------------------------

-- Telescope integration
local tele_status_ok, _ = pcall(require, "telescope")
if not tele_status_ok then
	return
end


local wk = require('which-key')
-- skogix/keymaps/neorg.lua
require('skogix.keymaps.neorg').globals(wk)




wk.register({
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
		['P'] = { "<cmd>Telescope pickers<cr>", '[search] pickers' },
		['p'] = { function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root}) end, '[search] plugins' },
      -- {
      --   "<leader>fp",
      --   function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      --   desc = "Find Plugin File",
      -- },
		['q'] = { '<cmd>Telescope quickfix<cr>', '[search] quickfix list' },
		['r'] = { "<cmd>Telescope registers<cr>", '[search] registers' },
		['S'] = { "<cmd>Telescope git_files search_dirs={'~/.config/svim/lua'}<cr>", '[search] lua/skogix files' },
		['s'] = { "<cmd>Telescope find_files search_dirs={'~/.config/svim/lua'}<cr>", '[search] lua/skogix files' },
		-- ['s'] = { "<cmd>Telescope git_files<cr>", '[search] files' },
		-- ['S'] = { "<cmd>Telescope find_files<cr>", '[search] files' },
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
		t = { util.Open_lazyterm2, '[term] root' },
		T = {function() LazyVim.terminal() end, '[term] cwd' },
		cd = { function()
			local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
			if bufdir ~= nil and vim.uv.fs_stat(bufdir) then
				vim.cmd.tcd(bufdir)
				vim.notify(bufdir)
			end
		end, "Change Tab Directory" },
		-- a = { function()
		-- 	if vim.bo.filetype ~= 'qf' then
		-- 		vim.diagnostic.setloclist({ open = false })
		-- 	end
		-- 	util.edit.toggle_list('loclist')
		-- end, "Open Location List" },
	}, -- }}}
	u = { -- {{{ u
		name = 'ui',
		f = { function() LazyVim.format.toggle() end, "Toggle Auto Format (Global)" },
		F = { function() LazyVim.format.toggle(true) end, "Toggle Auto Format (Buffer)" },
		s = { function() LazyVim.toggle('spell') end, "Toggle Spelling" },
		w = { function() LazyVim.toggle('wrap') end, "Toggle Word Wrap" },
		L = { function() LazyVim.toggle('relativenumber') end, "Toggle Relative Line Numbers" },
		l = { function() LazyVim.toggle.number() end, "Toggle Line Numbers" },
		-- d = { function() util.edit.diagnostic_toggle(false) end, "Disable Diagnostics" },
		-- D = { function() util.edit.diagnostic_toggle(true) end, "Disable All Diagnostics" },
		o = { "<cmd>setlocal nolist!<CR>", "Toggle Whitespace Symbols" },
		u = { "<cmd>nohl[search]<CR>", "Hide Search Highlight" },
		h = { function() LazyVim.toggle.inlay_hints() end, "Toggle Inlay Hints" },
		T = { function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, "Toggle Treesitter Highlight" },
		b = { function() LazyVim.toggle('background', false, {'light', 'dark'}) end, "Toggle Background" },
	}, -- }}}
	x = { -- {{{ x
		name = 'diagnostics/quickfix',
		-- l = { function() util.edit.toggle_list('loclist') end, "Toggle Location List" },
		-- q = { function() util.edit.toggle_list('quickfix') end, "Toggle Quickfix List" },
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





-- vim:foldmethod=marker
