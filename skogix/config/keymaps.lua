-- local Util = require('skogix.util')
local map = vim.keymap.set


-- skogix/keymaps/neorg.lua
-- require('skogix.keymaps.neorg').globals(wk)

-- {{{ functions
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
local function open_readme()
	local readme_path = vim.fn.globpath('.', '**/readme.norg', true, 0)[1]

	if readme_path == nil then
		readme_path = vim.fn.globpath('.', '**/README.md', true, 1)[1]
	end

	if readme_path ~= nil then
		vim.cmd("tabnew")
		vim.cmd("edit " .. readme_path)
	else
		print("Neither readme.norg nor readme.md found in the current directory.")
	end
end
--- }}}
-- {{{ basics
-- Copy paste
map({ 'n', 'x' }, '<leader>y', '[copy] to system clipboard') -- copy to system clipboard
map({ 'n', 'x' }, '<leader>p', '[paste] to system clipboard') -- paste from system clipboard
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
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })--add
-- }}}
-- {{{ maps
-- Close all fold except the current one.
map("n", "zv", "zMzvzz", {--add
	desc = "Close all folds except the current one",
})

-- Close current fold when open. Always open next fold.
map("n", "zj", "zcjzOzz", {--add
	desc = "Close current fold when open. Always open next fold.",
})

-- Close current fold when open. Always open previous fold.
map("n", "zk", "zckzOzz", {--add
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

-- -- skogix/keymaps/neorg.lua
-- require('skogix.keymaps.neorg').globals(wk)

-- which-key integration
if pcall(require, "which-key") then
	local wk = require('which-key')
	wk.register({s = {name="[search]"}},{})
end

-- add_to_which_key()

-- vim:foldmethod=marker
