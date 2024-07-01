-- Neovim keymaps
-- This file is automatically loaded by skogix.config.init

-- local Util = require('skogix.util')
local map = vim.keymap.set
local wk = require('which-key')

local function open_readme()
	local readme_path = vim.fn.globpath('.', '**/readme.norg', true, 0)[1]

	if readme_path == nil then
		readme_path = vim.fn.globpath('.', '**/readme.md', true, 1)[1]
	end

	if readme_path ~= nil then
		vim.cmd("edit " .. readme_path)
	else
		print("Neither readme.norg nor readme.md found in the current directory.")
	end
end

map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Down' })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Up' })




-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Copy paste
map({ 'n', 'x' }, '<leader>y', [["+y]]) -- copy to system clipboard
map({ 'n', 'x' }, '<leader>p', [["+p]]) -- paste from system clipboard

-- TODO: keymaps
-- Diagnostic keymaps
-- map('n', '[d', vim.diagnostic.goto_prev, { 'Go to previous [D]iagnostic message' })
-- map('n', ']d', vim.diagnostic.goto_next, { 'Go to next [D]iagnostic message' })
-- map('n', '<leader>e', vim.diagnostic.open_float, { 'Show diagnostic [E]rror messages' })
-- map('n', '<leader>q', vim.diagnostic.setloclist, { 'Open diagnostic [Q]uickfix list' })

-- ------------------------------------------------------------------------- }}}
-- {{{ Folding commands.

-- Author: Karl Yngve Lervåg
--    See: https://github.com/lervag/dotnvim

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

-- Move live up or down
-- moving
map("n", "<A-Down>", ":m .+1<CR>", { desc = "" })
map("n", "<A-Up>", ":m .-2<CR>", { desc = "" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "" })

-- -- Gitsigns
-- -- Add toggle gitsigns blame line
-- if Util.has("gitsigns.nvim") then
--   keymap("n", "<leader>ub", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", {
--     "Toggle current line blame",
--   })
-- end

map('n', ';', ':', { desc = 'command' })

-- -- Blame line
-- keymap("n", "<leader>gl", LazyVim.lazygit.blame_line, { "Git Blame Line" })

-- Telescope
local picker = require('telescope.pickers')
local telescope = require('telescope')
local normal = {
	-- [';'] = {':', 'command'},
	[']'] = {name = 'next'},
	['['] = {name = 'prev'},
	s = {
		name = "search",
[';'] = { "<cmd>Telescope commands<cr>", 'search commands' },
['/'] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", 'search buffer' },
['<'] = { "<cmd>Telescope search_history<cr>", 'search history' },
[':'] = { "<cmd>Telescope command_history<cr>", 'search command history' },
['D'] = {'<cmd>Telescope diagnostics<CR>', 'search workspace diagnostics' },
['H'] = {'<cmd>Telescope help_tags<CR>', 'search help pages' },
['M'] = {'<cmd>Telescope man_pages<CR>', 'Man Pages' },
['O'] = { "<cmd>Telescope oldfiles<cr>", 'search old files' },
['W'] = {'<cmd>Telescope grep_string<CR>', 'Word' },
['b'] = { "<cmd>Telescope buffers<cr>", 'search buffers' },
['c'] = {'<cmd>Telescope colorscheme<CR>', 'Colorscheme' },
['d'] = {'<cmd>Telescope diagnostics bufnr=0<CR>', 'search document diagnostics'},
['g'] = { "<cmd>Telescope live_grep<cr>", 'search grep' },
['h'] = { "<cmd>Telescope highlights<cr>", 'search highlights' },
['j'] = { "<cmd>Telescope jumplist<cr>", 'search jumplist' },
['k'] = {'<cmd>Telescope keymaps<CR>', 'search key maps' },
['l'] = {'<cmd>Telescope loclist<cr>', 'Location List' },
['m'] = { "<cmd>Telescope marks<cr>", 'search marks' },
['o'] = { "<cmd>Telescope vim_options<cr>", 'search neovim options' },
['p'] = { "<cmd>Telescope pickers<cr>", 'search pickers' },
['q'] = {'<cmd>Telescope quickfix<cr>', 'Quickfix List' },
['r'] = { "<cmd>Telescope registers<cr>", 'search registers' },
['s'] = { "<cmd>Telescope git_files<cr>", 'search files' },
['S'] = { "<cmd>Telescope find_files<cr>", 'search files' },
['w'] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", 'search workspace symbols' },
['la'] = {'<cmd>Telescope lsp_code_actions<CR>', 'Code Actions' },
['lb'] = {'<cmd>Telescope lsp_range_code_actions<CR>', 'Code Actions' },
['ld'] = {'<cmd>Telescope lsp_definitions<CR>', 'Definitions' },
['li'] = {'<cmd>Telescope lsp_implementations<CR>', 'Implementations' },
['lr'] = {'<cmd>Telescope lsp_references<CR>', 'References' },
		-- ['x'] = {
		-- 	function()
		-- 		require('telescope.builtin').lsp_document_symbols({
		-- 			symbols = {
		-- 				'Class',
		-- 				'Function',
		-- 				'Method',
		-- 				'Constructor',
		-- 				'Interface',
		-- 				'Module',
		-- 				'Struct',
		-- 				'Trait',
		-- 				'Field',
		-- 				'Property',
		-- 				'Enum',
		-- 				'Constant',
		-- 			},
		-- 		})
		-- 	end,
		-- 	name = 'Goto Symbol',
		-- },
		-- ['X'] = {
		-- 	function()
		-- 		require('telescope.builtin').lsp_dynamic_workspace_symbols({
		-- 			symbols = {
		-- 				'Class',
		-- 				'Function',
		-- 				'Method',
		-- 				'Constructor',
		-- 				'Interface',
		-- 				'Module',
		-- 				'Struct',
		-- 				'Trait',
		-- 				'Field',
		-- 				'Property',
		-- 				'Enum',
		-- 				'Constant',
		-- 			},
		-- 		})
		-- 	end,
		-- 	name = 'Goto Symbol (Workspace)',
		-- },
	},
}

local leader = {
	b = { name = 'buffer' },
	c = { name = 'code' },
	f = { name = 'file/find' },
	h = { name = 'harpoon' },
	m = { name = 'tools' },
	n = { name = 'notes' },
	s = { name = 'search' },
	t = { name = 'toggle/tools' },
	u = { name = 'ui' },
	x = { name = 'diagnostics/quickfix' },
	g = {
		name = "git",
		['s'] = { '<cmd>Telescope git_status<CR>', 'Git Status' },
		['r'] = { '<cmd>Telescope git_branches<CR>', 'Git Branches' },
		['l'] = { '<cmd>Telescope git_commits<CR>', 'Git Commits' },
		['L'] = { '<cmd>Telescope git_bcommits<CR>', 'Git Buffer Commits' },
		['h'] = { '<cmd>Telescope git_stash<CR>', 'Git Stashes' },
		['c'] = { '<cmd>Telescope git_bcommits_range<CR>', 'Git Buffer Commits Range' },
	},
}

local opts = {prefix = "<leader>"}
wk.register(leader, opts)
wk.register(normal, {})
--
-- -- Rafi's Neovim keymaps
-- -- github.com/rafi/vim-config
-- -- ===
-- -- This file is automatically loaded by rafi.config.init
--
-- local Util = require('rafi.util')
-- local map = vim.keymap.set
--
-- -- Package-manager
-- map('n', '<leader>l', '<cmd>Lazy<cr>', { 'Open Lazy UI' })
-- map('n', '<leader>mx', '<cmd>LazyExtras<CR>', { 'Open Plugin Extras' })
--
-- -- stylua: ignore start
--
-- -- Navigation {{{
--
-- -- Moves through display-lines, unless count is provided
-- map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, 'Down' })
-- map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, 'Up' })
--
-- if vim.F.if_nil(vim.g.elite_mode, false) then
-- 	-- Elite-mode: Arrow-keys resize window
-- 	map('n', '<Up>', '<cmd>resize +1<cr>', { 'Increase Window Height' })
-- 	map('n', '<Down>', '<cmd>resize -1<cr>', { 'Decrease Window Height' })
-- 	map('n', '<Left>', '<cmd>vertical resize +1<cr>', { 'Increase Window Width' })
-- 	map('n', '<Right>', '<cmd>vertical resize -1<cr>', { 'Decrease Window Width' })
-- else
-- 	-- Moves through display-lines, unless count is provided
-- 	map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, 'Down' })
-- 	map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, 'Up' })
--
-- 	-- Resize window using <ctrl> arrow keys
-- 	map('n', '<C-Up>', '<cmd>resize +2<cr>', { 'Increase Window Height' })
-- 	map('n', '<C-Down>', '<cmd>resize -2<cr>', { 'Decrease Window Height' })
-- 	map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { 'Decrease Window Width' })
-- 	map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { 'Increase Window Width' })
-- end
--
-- if not vim.env.TMUX or vim.uv.os_uname().sysname == 'Windows_NT' then
-- 	-- Move to window using the <ctrl> hjkl keys
-- 	map('n', '<C-h>', '<C-w>h', { 'Go to Left Window', remap = true })
-- 	map('n', '<C-j>', '<C-w>j', { 'Go to Lower Window', remap = true })
-- 	map('n', '<C-k>', '<C-w>k', { 'Go to Upper Window', remap = true })
-- 	map('n', '<C-l>', '<C-w>l', { 'Go to Right Window', remap = true })
-- 	-- Terminal Mappings
-- 	map('t', '<C-h>', '<cmd>wincmd h<cr>', { 'Go to Left Window' })
-- 	map('t', '<C-j>', '<cmd>wincmd j<cr>', { 'Go to Lower Window' })
-- 	map('t', '<C-k>', '<cmd>wincmd k<cr>', { 'Go to Upper Window' })
-- 	map('t', '<C-l>', '<cmd>wincmd l<cr>', { 'Go to Right Window' })
-- end
--
-- -- Easier line-wise movement
-- map('n', 'gh', 'g^', { 'Jump to first screen character' })
-- map('n', 'gl', 'g$', { 'Jump to last screen character' })
--
-- -- Navigation in command line
-- map('c', '<C-h>', '<Home>')
-- map('c', '<C-l>', '<End>')
-- map('c', '<C-f>', '<Right>')
-- map('c', '<C-b>', '<Left>')
--
-- -- Scroll step sideways
-- map('n', 'zl', 'z4l')
-- map('n', 'zh', 'z4h')
--
-- -- Toggle fold or select option from popup menu
-- map('n', '<CR>', function()
-- 	return vim.fn.pumvisible() == 1 and '<CR>' or 'za'
-- end, { expr = true, 'Toggle Fold' })
--
-- -- Focus the current fold by closing all others
-- map('n', '<S-Return>', 'zMzv', { remap = true, 'Focus Fold' })
--
-- -- Tabs: Many ways to navigate them
-- map('n', '<A-j>', '<cmd>tabnext<CR>', { 'Next Tab' })
-- map('n', '<A-k>', '<cmd>tabprevious<CR>', { 'Previous Tab' })
-- map('n', '<A-[>', '<cmd>tabprevious<CR>', { 'Previous Tab' })
-- map('n', '<A-]>', '<cmd>tabnext<CR>', { 'Next Tab' })
-- map('n', '<C-Tab>', '<cmd>tabnext<CR>', { 'Next Tab' })
-- map('n', '<C-S-Tab>', '<cmd>tabprevious<CR>', { 'Previous Tab' })
--
-- -- Moving tabs
-- map('n', '<A-{>', '<cmd>-tabmove<CR>', { 'Tab Move Backwards' })
-- map('n', '<A-}>', '<cmd>+tabmove<CR>', { 'Tab Move Forwards' })
--
-- -- buffers
-- map('n', '<leader>bb', '<cmd>e #<CR>', { 'Switch to Other Buffer' })
-- map('n', '<leader>`', '<cmd>e #<CR>', { 'Switch to Other Buffer' })
-- map('n', '<leader>bD', '<cmd>:bd<cr>', { 'Delete Buffer and Window' })
--
-- -- }}}
-- -- Selection {{{
--
-- map('n', '<Leader><Leader>', 'V', { 'Visual Mode' })
-- map('x', '<Leader><Leader>', '<Esc>', { 'Exit Visual Mode' })
--
-- -- Select last paste
-- map('n', 'vsp', "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, 'Select Paste' })
--
-- -- Quick substitute within selected area
-- map('x', 'sg', ':s//gc<Left><Left><Left>', { 'Substitute Within Selection' })
--
-- -- C-r: Easier search and replace visual/select mode
-- map(
-- 	'x',
-- 	'<C-r>',
-- 	":<C-u>%s/\\V<C-R>=v:lua.require'rafi.util.edit'.get_visual_selection()<CR>"
-- 		.. '//gc<Left><Left><Left>',
-- 	{ 'Replace Selection' }
-- )
--
-- -- Re-select blocks after indenting in visual/select mode
-- map('x', '<', '<gv', { 'Indent Right and Re-select' })
-- map('x', '>', '>gv|', { 'Indent Left and Re-select' })
--
-- -- Use tab for indenting in visual/select mode
-- map('x', '<Tab>', '>gv|', { 'Indent Left' })
-- map('x', '<S-Tab>', '<gv', { 'Indent Right' })
--
-- -- Better block-wise operations on selected area
-- local blockwise_force = function(key)
-- 	local c_v = vim.api.nvim_replace_termcodes('<C-v>', true, false, true)
-- 	local keyseq = {
-- 		I  = { v = '<C-v>I',  V = '<C-v>^o^I', [c_v] = 'I' },
-- 		A  = { v = '<C-v>A',  V = '<C-v>0o$A', [c_v] = 'A' },
-- 		gI = { v = '<C-v>0I', V = '<C-v>0o$I', [c_v] = '0I' },
-- 	}
-- 	return function()
-- 		return keyseq[key][vim.fn.mode()]
-- 	end
-- end
-- map('x', 'I',  blockwise_force('I'),  { expr = true, noremap = true, 'Blockwise Insert' })
-- map('x', 'gI', blockwise_force('gI'), { expr = true, noremap = true, 'Blockwise Insert' })
-- map('x', 'A',  blockwise_force('A'),  { expr = true, noremap = true, 'Blockwise Append' })
--
-- -- }}}
-- -- Jump to {{{
--
-- map('n', '[b', '<cmd>bprev<CR>', { 'Previous Buffer' })
-- map('n', ']b', '<cmd>bnext<CR>', { 'Next Buffer' })
-- map('n', ']q', vim.cmd.cnext, { 'Next Quickfix' })
-- map('n', '[q', vim.cmd.cprev, { 'Previous Quickfix' })
-- map('n', ']a', '<cmd>lnext<CR>', { 'Next Loclist' })
-- map('n', '[a', '<cmd>lprev<CR>', { 'Previous Loclist' })
--
-- -- Whitespace jump (see plugin/whitespace.vim)
-- map('n', ']z', function() Util.edit.whitespace_jump(1) end, { 'Next Whitespace' })
-- map('n', '[z', function() Util.edit.whitespace_jump(-1) end, { 'Previous Whitespace' })
--
-- -- Diagnostic movement
-- local diagnostic_goto = function(next, severity)
-- 	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
-- 	local severity_int = severity and vim.diagnostic.severity[severity] or nil
-- 	return function()
-- 		go({ severity = severity_int })
-- 	end
-- end
-- map('n', '<Leader>ce', vim.diagnostic.open_float, { 'Line Diagnostics' })
-- map('n', ']d', diagnostic_goto(true), { 'Next Diagnostic' })
-- map('n', '[d', diagnostic_goto(false), { 'Prev Diagnostic' })
-- map('n', ']e', diagnostic_goto(true, 'ERROR'), { 'Next Error' })
-- map('n', '[e', diagnostic_goto(false, 'ERROR'), { 'Prev Error' })
-- map('n', ']w', diagnostic_goto(true, 'WARN'), { 'Next Warning' })
-- map('n', '[w', diagnostic_goto(false, 'WARN'), { 'Prev Warning' })
--
-- -- }}}
-- -- Clipboard {{{
-- -- ===
--
-- -- Paste in visual-mode without pushing to register
-- map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, 'Paste' })
-- map('x', 'P', 'P:let @+=@0<CR>:let @"=@0<CR>', { silent = true, 'Paste In-place' })
--
-- -- Yank buffer's relative path to clipboard
-- map('n', '<Leader>y', function()
-- 	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.') or ''
-- 	vim.fn.setreg('+', path)
-- 	vim.notify(path, vim.log.levels.INFO, { title = 'Yanked relative path' })
-- end, { silent = true, 'Yank relative path' })
--
-- -- Yank absolute path
-- map('n', '<Leader>Y', function()
-- 	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p') or ''
-- 	vim.fn.setreg('+', path)
-- 	vim.notify(path, vim.log.levels.INFO, { title = 'Yanked absolute path' })
-- end, { silent = true, 'Yank absolute path' })
--
-- --- }}}
-- -- Coding {{{
--
-- -- Comment
-- map('n', '<Leader>v', 'gcc', { remap = true, 'Comment Line' })
-- map('x', '<Leader>v', 'gc', { remap = true, 'Comment Selection' })
--
-- -- Macros
-- map('n', '<C-q>', 'q', { 'Macro Prefix' })
--
-- -- Formatting
-- map({ 'n', 'v' }, '<leader>cf', function() LazyVim.format({ force = true }) end, { 'Format' })
-- map('n', '<leader>cif', '<cmd>LazyFormatInfo<CR>', { silent = true, 'Formatter Info' })
--
-- -- Start new line from any cursor position in insert-mode
-- map('i', '<S-Return>', '<C-o>o', { 'Start Newline' })
-- map('n', ']<Leader>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', { silent = true, 'Newline' })
-- map('n', '[<Leader>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', { silent = true, 'Newline' })
--
-- -- Drag current line(s) vertically and auto-indent
-- map('n', '<Leader>k', '<cmd>move-2<CR>==', { silent = true, 'Move line up' })
-- map('n', '<Leader>j', '<cmd>move+<CR>==', { silent = true, 'Move line down' })
-- map('x', '<Leader>k', ":move'<-2<CR>gv=gv", { silent = true, 'Move selection up' })
-- map('x', '<Leader>j', ":move'>+<CR>gv=gv", { silent = true, 'Move selection down' })
--
-- -- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
-- map('n', '<Leader>dd', 'm`""Y""P``', { 'Duplicate line' })
-- map('x', '<Leader>dd', '""Y""Pgv', { 'Duplicate selection' })
--
-- -- }}}
-- -- Search, substitute, diff {{{
--
-- -- Switch */g* and #/g#
-- map('n', '*', 'g*')
-- map('n', 'g*', '*')
-- map('n', '#', 'g#')
-- map('n', 'g#', '#')
--
-- -- Clear search with <Esc>
-- map('n', '<Esc>', '<cmd>noh<CR>', { 'Escape and Clear hlsearch' })
--
-- -- Use backspace key for matching pairs
-- map({ 'n', 'x' }, '<BS>', '%', { remap = true, 'Jump to Paren' })
--
-- -- Toggle diff on all windows in current tab
-- map('n', '<Leader>bf', function()
-- 	vim.cmd('windo diff' .. (vim.wo.diff and 'off' or 'this'))
-- end, { 'Diff Windows in Tab' })
--
-- -- }}}
-- -- Command & History {{{
--
-- -- Put vim command output into buffer
-- map('n', 'g!', ":put=execute('')<Left><Left>", { 'Paste Command' })
--
-- -- Switch history search pairs, matching my bash shell
-- map('c', '<Up>', '<C-p>')
-- map('c', '<Down>', '<C-n>')
-- map('c', '<C-p>', function()
-- 	return vim.fn.pumvisible() == 1 and '<C-p>' or '<Up>'
-- end, { expr = true })
-- map('c', '<C-n>', function()
-- 	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Down>'
-- end, { expr = true })
--
-- -- Use keywordprg
-- map('n', '<leader>K', '<cmd>norm! K<cr>', { 'Keywordprg' })
--
-- --- }}}
-- -- File operations {{{
--
-- -- Switch (tab) to the directory of the current opened buffer
-- map('n', '<Leader>cd', function()
-- 	local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
-- 	if bufdir ~= nil and vim.uv.fs_stat(bufdir) then
-- 		vim.cmd.tcd(bufdir)
-- 		vim.notify(bufdir)
-- 	end
-- end, { 'Change Tab Directory' })
--
-- -- New file
-- map('n', '<leader>fn', '<cmd>enew<cr>', { 'New File' })
--
-- -- Fast saving from all modes
-- map('n', '<Leader>w', '<cmd>write<CR>', { 'Save File' })
-- map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>write<CR>', { 'Save File' })
--
-- -- }}}
-- -- Editor UI {{{
--
-- -- Toggle list windows
-- map('n', '<leader>xl', function() Util.edit.toggle_list('loclist') end, { 'Toggle Location List' })
-- map('n', '<leader>xq', function() Util.edit.toggle_list('quickfix') end, { 'Toggle Quickfix List' })
--
-- -- Set locations with diagnostics and open the list.
-- map('n', '<Leader>a', function()
-- 	if vim.bo.filetype ~= 'qf' then
-- 		vim.diagnostic.setloclist({ open = false })
-- 	end
-- 	Util.edit.toggle_list('loclist')
-- end, { 'Open Location List' })
--
-- map('n', '<leader>uf', function() LazyVim.format.toggle() end, { 'Toggle Auto Format (Global)' })
-- map('n', '<leader>uF', function() LazyVim.format.toggle(true) end, { 'Toggle Auto Format (Buffer)' })
-- map('n', '<leader>us', function() LazyVim.toggle('spell') end, { 'Toggle Spelling' })
-- map('n', '<leader>uw', function() LazyVim.toggle('wrap') end, { 'Toggle Word Wrap' })
-- map('n', '<leader>uL', function() LazyVim.toggle('relativenumber') end, { 'Toggle Relative Line Numbers' })
-- map('n', '<leader>ul', function() LazyVim.toggle.number() end, { 'Toggle Line Numbers' })
-- map('n', '<Leader>ud', function() Util.edit.diagnostic_toggle(false) end, { 'Disable Diagnostics' })
-- map('n', '<Leader>uD', function() Util.edit.diagnostic_toggle(true) end, { 'Disable All Diagnostics' })
--
-- map('n', '<Leader>uo', '<cmd>setlocal nolist!<CR>', { 'Toggle Whitespace Symbols' })
-- map('n', '<Leader>uu', '<cmd>nohlsearch<CR>', { 'Hide Search Highlight' })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map('n', '<leader>uc', function() LazyVim.toggle('conceallevel', false, { 0, conceallevel }) end, { 'Toggle Conceal' })
-- if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
-- 	map('n', '<leader>uh', function() LazyVim.toggle.inlay_hints() end, { 'Toggle Inlay Hints' })
-- end
-- map('n', '<leader>uT', function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { 'Toggle Treesitter Highlight' })
-- map('n', '<leader>ub', function() LazyVim.toggle('background', false, {'light', 'dark'}) end, { 'Toggle Background' })
--
-- -- Show treesitter nodes under cursor
-- map('n', '<Leader>ui', vim.show_pos, { 'Show Treesitter Node' })
-- map('n', '<leader>uI', '<cmd>InspectTree<cr>', { 'Inspect Tree' })
--
-- -- Clear search, diff update and redraw taken from runtime/lua/_editor.lua
-- map(
-- 	'n',
-- 	'<leader>ur',
-- 	'<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><CR>',
-- 	{ 'Redraw / Clear hlsearch / Diff Update' }
-- )
--
-- -- }}}
-- -- Plugins & Tools {{{
--
-- -- Append mode-line to current buffer
-- map('n', '<Leader>ml', function() Util.edit.append_modeline() end, { 'Append Modeline' })
--
-- -- Jump entire buffers throughout jumplist
-- map('n', 'g<C-i>', function() Util.edit.jump_buffer(1) end, { 'Jump to newer buffer' })
-- map('n', 'g<C-o>', function() Util.edit.jump_buffer(-1) end, { 'Jump to older buffer' })
--
-- -- Context aware menu. See lua/lib/contextmenu.lua
-- map('n', '<RightMouse>', function() Util.contextmenu.show() end)
-- map('n', '<LocalLeader>c', function() Util.contextmenu.show() end, { 'Content-aware menu' })
--
-- -- Lazygit
-- map('n', '<leader>tg', function() LazyVim.lazygit( { cwd = LazyVim.root.git() }) end, { 'Lazygit (Root Dir)' })
-- map('n', '<leader>tG', function() LazyVim.lazygit() end, { 'Lazygit (cwd)' })
-- map('n', '<leader>tm', LazyVim.lazygit.blame_line, { 'Git Blame Line' })
-- map('n', '<leader>tf', function()
-- 	local git_path = vim.api.nvim_buf_get_name(0)
-- 	LazyVim.lazygit({args = { '-f', vim.trim(git_path) }})
-- end, { 'Lazygit Current File History' })
--
-- -- Terminal
-- map('t', '<Esc><Esc>', '<C-\\><C-n>', { 'Enter Normal Mode' })
-- local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
-- map('n', '<leader>tt', lazyterm, { 'Terminal (Root Dir)' })
-- map('n', '<leader>tT', function() LazyVim.terminal() end, { 'Terminal (cwd)' })
--
-- if vim.fn.has('mac') then
-- 	-- Open the macOS dictionary on current word
-- 	map('n', '<Leader>?', '<cmd>silent !open dict://<cword><CR>', { 'Dictionary' })
-- end
--
-- -- }}}
-- -- Windows and buffers {{{
--
-- -- Ultimatus Quitos
-- if vim.F.if_nil(vim.g.window_q_mapping, true) then
-- 	map('n', 'q', function()
-- 		local plugins = {
-- 			'blame',
-- 			'checkhealth',
-- 			'fugitive',
-- 			'fugitiveblame',
-- 			'help',
-- 			'httpResult',
-- 			'lspinfo',
-- 			'notify',
-- 			'PlenaryTestPopup',
-- 			'qf',
-- 			'spectre_panel',
-- 			'startuptime',
-- 			'tsplayground',
-- 		}
-- 		local buf = vim.api.nvim_get_current_buf()
-- 		if vim.tbl_contains(plugins,
-- 		vim.bo[buf].filetype) then
-- 			vim.bo[buf].buflisted = false
-- 			vim.api.nvim_win_close(0, false)
-- 		else
-- 			-- Find non-floating windows
-- 			local wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, win)
-- 				if vim.api.nvim_win_get_config(win).zindex then
-- 					return nil
-- 				end
-- 				return win
-- 			end)
-- 			-- If last window, quit
-- 			if #wins > 1 then
-- 				vim.api.nvim_win_close(0, false)
-- 			else
-- 				vim.cmd[[quit]]
-- 			end
-- 		end
-- 	end, { 'Close window' })
-- end
--
-- map('n', '<leader>qq', '<cmd>qa<cr>', { 'Quit All' })
--
-- -- Switch with adjacent window
-- map('n', '<C-x>', '<C-w>x<C-w>w', { remap = true, 'Swap adjacent windows' })
--
-- map('n', 'sb', '<cmd>buffer#<CR>', { 'Alternate buffer' })
-- map('n', 'sc', '<cmd>close<CR>', { 'Close window' })
-- map('n', 'sd', '<cmd>bdelete<CR>', { 'Buffer delete' })
-- map('n', 'sv', '<cmd>split<CR>', { 'Split window horizontally' })
-- map('n', 'sg', '<cmd>vsplit<CR>', { 'Split window vertically' })
-- map('n', 'st', '<cmd>tabnew<CR>', { 'New tab' })
-- map('n', 'so', '<cmd>only<CR>', { 'Close other windows' })
-- map('n', 'sq', '<cmd>quit<CR>', { 'Quit' })
--
-- -- Empty buffer but leave window
-- map('n', 'sx', function()
-- 	require('mini.bufremove').delete(0, false)
-- 	vim.cmd.enew()
-- end, { 'Delete buffer and open new' })
--
-- -- Toggle window zoom
-- map('n', 'sz', function()
-- 	local width = vim.o.columns - 15
-- 	local height = vim.o.lines - 5
-- 	if vim.api.nvim_win_get_width(0) >= width then
-- 		vim.cmd.wincmd('=')
-- 	else
-- 		vim.cmd('vertical resize ' .. width)
-- 		vim.cmd('resize ' .. height)
-- 		vim.cmd('normal! ze')
-- 	end
-- end, { 'Maximize window' })
-- -- }}}
--
-- -- vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
