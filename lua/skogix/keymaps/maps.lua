local map = vim.keymap.set
local helpers = require("fn/helpers")
local wk = require("which-key")
local m = {
	n = "n",
	t = "t",
	v = "v",
}

---@class b {{},{}{}}
local b = {}

b = { -- basics
	{ { m.n }, ";", ":", "command" },
	{ m.n, "<leader>y", "", "[copy] to system clipboard" },
	{ m.n, "<leader>p", "", "[paste] to system clipboard" },
	{ m.n, "<C-h>", "<C-w><C-h>", "Move focus to the left window" },
	{ m.n, "<C-l>", "<C-w><C-l>", "Move focus to the right window" },
	{ m.n, "<C-j>", "<C-w><C-j>", "Move focus to the lower window" },
	{ m.n, "<C-k>", "<C-w><C-k>", "Move focus to the upper window" },
	{ m.n, "<Esc>", "<cmd>nohlsearch<CR>", "" },
}

---@function 
function Global()
	for _, a in pairs(b) do
		vim.keymap.set(a[1], a[2], a[3], { desc = a[4] })
	end
end

-- skogix/keymaps/neorg.lua
require('skogix.keymaps.neorg').globals(wk)

-- which-key integration
if pcall(require, "which-key") then
	local wk = require("which-key")
	wk.register({ s = { name = "[search]" } }, {})
end

-- add_to_which_key()

-- vim:foldmethod=marker
-- Telescope
local picker = require("telescope.pickers")
local telescope = require("telescope")
local normal = {
	["]"] = {
		name = "next",
		-- map('n', ']d', vim.diagnostic.goto_next, { 'Go to next [D]iagnostic message' })
		["]a"] = { "<cmd>lnext<CR>", "Next Loclist" },
		["]b"] = { "<cmd>bnext<CR>", "Next Buffer" },
		["]q"] = { vim.cmd.cnext, "Next Quickfix" },
	},
	["["] = {
		name = "prev",
		-- map('n', '[d', vim.diagnostic.goto_prev, { 'Go to previous [D]iagnostic message' })
		["[b"] = { "<cmd>bprev<CR>", "Previous Buffer" },
		["[a"] = { "<cmd>lprev<CR>", "Previous Loclist" },
		["[q"] = { vim.cmd.cprev, "Previous Quickfix" },
	},
	s = { -- {{{ s
		name = "[search]",
		[";"] = { "<cmd>Telescope commands<cr>", "[search] commands" },
		["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[search] buffer" },
		["<"] = { "<cmd>Telescope search_history<cr>", "[search] history" },
		[":"] = { "<cmd>Telescope command_history<cr>", "[search] command history" },
		["D"] = { "<cmd>Telescope diagnostics<CR>", "[search] workspace diagnostics" },
		["H"] = { "<cmd>Telescope help_tags<CR>", "[search] help pages" },
		["M"] = { "<cmd>Telescope man_pages<CR>", "[search] man pages" },
		["O"] = { "<cmd>Telescope oldfiles<cr>", "[search] old files" },
		["W"] = { "<cmd>Telescope grep_string<CR>", "[search] current word" },
		["b"] = { "<cmd>Telescope buffers<cr>", "[search] buffers" },
		["c"] = { "<cmd>Telescope colorscheme<CR>", "[search] colorscheme" },
		["d"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "[search] document diagnostics" },
		["g"] = { "<cmd>Telescope live_grep<cr>", "[search] grep" },
		["h"] = { "<cmd>Telescope highlights<cr>", "[search] highlights" },
		["j"] = { "<cmd>Telescope jumplist<cr>", "[search] jumplist" },
		["k"] = { "<cmd>Telescope keymaps<CR>", "[search] key maps" },
		l = {
			name = "[search lsp]",
			["a"] = { "<cmd>Telescope lsp_code_actions<CR>", "[search lsp] code actions" },
			["b"] = { "<cmd>Telescope lsp_range_code_actions<CR>", "[search lsp] code actions" },
			["d"] = { "<cmd>Telescope lsp_definitions<CR>", "[search lsp] definitions" },
			["i"] = { "<cmd>Telescope lsp_implementations<CR>", "[search lsp] implementations" },
			["r"] = { "<cmd>Telescope lsp_references<CR>", "[search lsp] references" },
		},
		["L"] = { "<cmd>Telescope loclist<cr>", "[search] location list" },
		["m"] = { "<cmd>Telescope marks<cr>", "[search] marks" },
		["o"] = { "<cmd>Telescope vim_options<cr>", "[search] neovim options" },
		["P"] = { "<cmd>Telescope pickers<cr>", "[search] pickers" },
		["p"] = {
			function()
				require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
			end,
			"[search] plugins",
		},
		["q"] = { "<cmd>Telescope quickfix<cr>", "[search] quickfix list" },
		["r"] = { "<cmd>Telescope registers<cr>", "[search] registers" },
		["S"] = {
			"<cmd>Telescope git_files search_dirs={'~/.config/nvim/lua/skogix/'}<cr>",
			"[search] lua/skogix files",
		},
		["s"] = {
			"<cmd>Telescope find_files search_dirs={'~/.config/nvim/lua/skogix/'}<cr>",
			"[search] lua/skogix files",
		},
		-- ['s'] = { "<cmd>Telescope git_files<cr>", '[search] files' },
		-- ['S'] = { "<cmd>Telescope find_files<cr>", '[search] files' },
		["w"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "[search] workspace symbols" },
	}, -- }}}
}

-- Diagnostic keymaps
-- map('n', '<leader>e', vim.diagnostic.open_float, { 'Show diagnostic [E]rror messages' })
-- map('n', '<leader>q', vim.diagnostic.setloclist, { 'Open diagnostic [Q]uickfix list' })
local leader = {
	a = { -- {{{ a
		name = "ai",
		["a"] = {
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end,
			"CopilotChat - Quick chat",
		},
	}, -- }}}
	b = { name = "buffer" },
	c = { -- {{{ c
		name = "code",
		f = {
			function()
				LazyVim.format({ force = true })
			end,
			"Format",
		},
		i = { "<cmd>LazyFormatInfo<CR>", "Formatter Info" },
	}, -- }}}
	f = { name = "file/find" },
	h = { name = "harpoon" },
	m = { name = "tools" },
	n = { name = "notes" },
	t = { -- {{{ t
		name = "term",
		-- t = { util.Open_lazyterm2, "[term] root" },
		T = {
			function()
				LazyVim.terminal()
			end,
			"[term] cwd",
		},
		cd = {
			function()
				local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
				if bufdir ~= nil and vim.uv.fs_stat(bufdir) then
					vim.cmd.tcd(bufdir)
					vim.notify(bufdir)
				end
			end,
			"Change Tab Directory",
		},
		-- a = { function()
		-- 	if vim.bo.filetype ~= 'qf' then
		-- 		vim.diagnostic.setloclist({ open = false })
		-- 	end
		-- 	util.edit.toggle_list('loclist')
		-- end, "Open Location List" },
	}, -- }}}
	u = { -- {{{ u
		name = "ui",
		f = {
			function()
				LazyVim.format.toggle()
			end,
			"Toggle Auto Format (Global)",
		},
		F = {
			function()
				LazyVim.format.toggle(true)
			end,
			"Toggle Auto Format (Buffer)",
		},
		s = {
			function()
				LazyVim.toggle("spell")
			end,
			"Toggle Spelling",
		},
		w = {
			function()
				LazyVim.toggle("wrap")
			end,
			"Toggle Word Wrap",
		},
		L = {
			function()
				LazyVim.toggle("relativenumber")
			end,
			"Toggle Relative Line Numbers",
		},
		l = {
			function()
				LazyVim.toggle.number()
			end,
			"Toggle Line Numbers",
		},
		-- d = { function() util.edit.diagnostic_toggle(false) end, "Disable Diagnostics" },
		-- D = { function() util.edit.diagnostic_toggle(true) end, "Disable All Diagnostics" },
		o = { "<cmd>setlocal nolist!<CR>", "Toggle Whitespace Symbols" },
		u = { "<cmd>nohl[search]<CR>", "Hide Search Highlight" },
		h = {
			function()
				LazyVim.toggle.inlay_hints()
			end,
			"Toggle Inlay Hints",
		},
		T = {
			function()
				if vim.b.ts_highlight then
					vim.treesitter.stop()
				else
					vim.treesitter.start()
				end
			end,
			"Toggle Treesitter Highlight",
		},
		b = {
			function()
				LazyVim.toggle("background", false, { "light", "dark" })
			end,
			"Toggle Background",
		},
	}, -- }}}
	x = { -- {{{ x
		name = "diagnostics/quickfix",
		-- l = { function() util.edit.toggle_list('loclist') end, "Toggle Location List" },
		-- q = { function() util.edit.toggle_list('quickfix') end, "Toggle Quickfix List" },
	}, -- }}}
	g = { -- {{{ g
		name = "git",
	}, -- }}}
	i = { vim.show_pos, "Show Treesitter Node" },
	I = { "<cmd>InspectTree<cr>", "Inspect Tree" },
}

local opts = { prefix = "<leader>", mode = "n" }
wk.register(leader, opts)
wk.register(normal, { mode = "n" })



--
--
--
-- local settings = require("configuration")
-- local map = vim.keymap.set
--
-- local bindings = {}
-- if settings.enable_neotree then
-- 	map("n", "s", ":Neotree toggle<CR>")
-- 	bindings = {
-- 		name = "[search]",
-- 		b = { "<cmd>Telescope file_browser grouped=true<cr>", "File browser" },
-- 		e = { "<cmd>Neotree<cr>", "Open Neotree" },
-- 		f = { "<cmd>" .. require("utils.functions").project_files() .. "<cr>", "Find File" },
-- 		p = { "<cmd>Neotree reveal toggle<cr>", "Toggle Neotree" },
-- 		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
-- 		s = { "<cmd>w<cr>", "Save Buffer" },
-- 		z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
-- 	}
-- else
-- 	map("n", "<leader>T", ":NvimTreeFindFileToggle<CR>")
-- 	bindings = {
-- 		name = "Files",
-- 		b = { "<cmd>Telescope file_browser grouped=true<cr>", "File browser" },
-- 		e = { "<cmd>NvimTreeOpen<cr>", "Open NvimTree" },
-- 		f = { "<cmd>" .. require("utils.functions").project_files() .. "<cr>", "Find File" },
-- 		p = { "<cmd>NvimTreeFindFileToggle<cr>", "Toggle NvimTree" },
-- 		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
-- 		s = { "<cmd>w<cr>", "Save Buffer" },
-- 		z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
-- 	}
-- end
--
-- -- Hide the tabline, statusline, winbar with '<leader>s'
-- vim.api.nvim_set_keymap("n", "<leader>s", "", {
-- 	callback = function()
-- 		require("lualine").hide({
-- 			place = { "statusline", "tabline", "winbar" },
-- 			unhide = false,
-- 		})
-- 	end,
-- })
-- -- Unhide the tabline, statusline, winbar with '<leader>S'
-- vim.api.nvim_set_keymap("n", "<leader>S", "", {
-- 	callback = function()
-- 		require("lualine").hide({
-- 			place = { "statusline", "tabline", "winbar" },
-- 			unhide = true,
-- 		})
-- 	end,
-- })
--
-- -- Remap for dealing with visual line wraps
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
--
-- -- better indenting
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")
--
-- -- paste over currently selected text without yanking it
-- map("v", "p", '"_dp')
-- map("v", "P", '"_dP')
--
-- -- switch buffer
-- map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--
-- -- Cancel search highlighting with ESC
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })
--
-- -- move over a closing element in insert mode
-- map("i", "<C-l>", function()
-- 	return require("utils.functions").escapePair()
-- end)
--
-- -- search like you are used to
-- -- map("n", "<C-f>", "/", { desc = "Search buffer" })
--
-- -- save like your are used to
-- -- map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
--
-- -- toggles
-- map("n", "<leader>th", function()
-- 	vim.o.list = vim.o.list == false and true or false
-- end, { desc = "Toggle hidden chars" })
-- map("n", "<leader>tl", function()
-- 	vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
-- end, { desc = "Toggle sgincolumn" })
-- map("n", "<leader>tv", function()
-- 	vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
-- end, { desc = "Toggle virtualedit" })
-- map("n", "<leader>ts", function()
-- 	vim.o.spell = vim.o.spell == false and true or false
-- end, { desc = "Toggle spell" })
-- map("n", "<leader>tw", function()
-- 	vim.o.wrap = vim.o.wrap == false and true or false
-- end, { desc = "Toggle wrap" })
-- map("n", "<leader>tc", function()
-- 	vim.o.cursorline = vim.o.cursorline == false and true or false
-- end, { desc = "Toggle cursorline" })
-- map("n", "<leader>to", "<cmd>lua require('utils.functions').toggle_colorcolumn()<cr>", { desc = "Toggle colorcolumn" })
-- map("n", "<leader>tt", "<cmd>lua require('utils.utils').toggle_virtual_text()<cr>", { desc = "Toggle Virtualtext" })
-- map("n", "<leader>ts", "<cmd>SymbolsOutline<cr>", { desc = "Toggle SymbolsOutline" })
--
-- -- Neovim :Terminal
-- --
-- map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal emulator with escape" })
-- map("t", "<C-w>", "<Esc><C-w>")
-- --tmap <C-d> <Esc>:q<CR>
--
-- -- Custom Mappings (lua custom mappings are within individual lua config files)
-- --
-- -- Core
-- -- map("n", [[\]], "<leader>t")
-- map("n", "<leader>r", ":so ~/.config/nvim/init.vim<CR>")
-- map("x", "<leader>a", "gaip*")
-- map("n", "<leader>a", "gaip*")
-- -- map("n", "<leader>h", ":RainbowParentheses!!<CR>")
-- map("n", "<leader>j", ":set filetype=journal<CR>")
-- -- nmap <leader>k :ColorToggle<CR>
-- -- map("n", "<leader>l", ":Limelight!!<CR>")
-- -- map("x", "<leader>l", ":Limelight!!<CR>")
-- map("n", "<silent>", "<leader><leader> :noh<CR>")
-- map("n", "<silent>", "<F12> :set invlist<CR>")
-- map("n", "<Tab>", ":bnext<CR>")
-- map("n", "<S-Tab>", ":bprevious<CR>")
-- map("n", "<leader>$s", "<C-w>s<C-w>j:terminal<CR>:set nonumber<CR><S-a>")
-- map("n", "<leader>$v", "<C-w>v<C-w>l:terminal<CR>:set number<CR><S-a>")
--
-- -- Telescope mappings
-- -- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- -- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- -- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- -- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
-- -- nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
-- -- nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
-- -- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>")
-- map("n", "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
--
-- local wk = require("_skoooo.plugins.extras.skogix.which-key")
-- local default_options = { silent = true }
--
-- -- register non leader based mappings
-- wk.register({
-- 	sa = "Add surrounding",
-- 	sd = "Delete surrounding",
-- 	sh = "Highlight surrounding",
-- 	sn = "Surround update n lines",
-- 	sr = "Replace surrounding",
-- 	sF = "Find left surrounding",
-- 	sf = "Replace right surrounding",
-- 	ss = { "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<cr>", "Jump to character" },
-- 	st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
-- })
--
-- -- Register leader based mappings
-- wk.register({
-- 	["<tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
-- 	b = {
-- 		name = "Buffers",
-- 		b = {
-- 			"<cmd>Telescope buffers<cr>",
-- 			"Find buffer",
-- 		},
-- 		D = {
-- 			"<cmd>%bd|e#|bd#<cr>",
-- 			"Close all but the current buffer",
-- 		},
-- 		d = { "<cmd>Bdelete<cr>", "Close buffer" },
-- 	},
-- 	f = bindings,
-- 	P = {
-- 		name = "Lazy Plugins",
-- 		c = { "<cmd>Lazy check<cr>", "Lazy check" },
-- 		C = { "<cmd>Lazy clean<cr>", "Lazy clean" },
-- 		i = { "<cmd>Lazy install<cr>", "Lazy install" },
-- 		l = { "<cmd>Lazy<cr>", "Lazy menu" },
-- 		s = { "<cmd>Lazy sync<cr>", "Lazy sync" },
-- 		u = { "<cmd>Lazy update<cr>", "Lazy update" },
-- 	},
-- 	F = {
-- 		name = "Quickfix",
-- 		j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
-- 		k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
-- 		q = { "<cmd>lua require('utils.functions').toggle_qf()<cr>", "Toggle quickfix list" },
-- 		t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
-- 	},
-- 	t = { name = "Toggles" },
-- 	-- hydra heads
-- 	s = { "Search" },
-- 	w = { "Windows" },
-- 	z = { "Spelling" },
-- }, { prefix = "<leader>", mode = "n", default_options })
return {}
