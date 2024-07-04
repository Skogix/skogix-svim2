-- Define a module M
local M = {}

-- This function sets up the configuration for Skogix.
-- It loads the 'autocmds' configuration file if a file is being opened.
-- It also creates an autocmd group and a user autocmd that loads 'autocmds' and 'keymaps' configuration files when the 'VeryLazy' pattern is matched.
function M.setup()
	-- Autocmds can be loaded lazily when not opening a file
	local lazy_autocmds = vim.fn.argc(-1) == 0
	if not lazy_autocmds then
		M.load('autocmds')
	end

	local group = vim.api.nvim_create_augroup('SVim', { clear = true })
	vim.api.nvim_create_autocmd('User', {
		group = group,
		pattern = 'VeryLazy',
		callback = function()
			if lazy_autocmds then
				M.load('autocmds')
			end
			M.load('keymaps')
		end,
	})
end

-- This function loads the specified configuration file from lua/skogix/config/* and lua/config/* directories.
-- @param name The name of the configuration file to load. It can be 'autocmds', 'options', or 'keymaps'.
function M.load(name)
	local function _load(mod)
		if require('lazy.core.cache').find(mod)[1] then
			LazyVim.try(function()
				require(mod)
			end, { msg = 'Failed loading ' .. mod })
		end
	end
	-- Always load skogix file, then user file
	_load('skogix.config.' .. name)
	_load('config.' .. name)
	if vim.bo.filetype == 'lazy' then
		vim.cmd([[do VimResized]])
	end
	local pattern = 'Svim' .. name:sub(1, 1):upper() .. name:sub(2)
	vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

-- This function is the main entry-point once lazy.nvim is set-up.
-- It is called from `lua/skogix/plugins/init.lua`
M.did_init = false
function M.init()
	if M.did_init then
		return
	end
	M.did_init = true
	local plugin = require('lazy.core.config').spec.plugins.LazyVim
	if plugin then
		---@diagnostic disable-next-line: undefined-field
		vim.opt.rtp:append(plugin.dir)
	end

	-- This is premature by purpose, to load the LazyVim global.
	local LazyVimConfig = require('lazyvim.config')

	-- Delay notifications till vim.notify was replaced or after 500ms
	LazyVim.lazy_notify()

	-- Load options here, before lazy init while sourcing plugin modules
	-- this is needed to make sure options will be correctly applied
	-- after installing missing plugins
	M.load('options')

	LazyVim.plugin.setup()
	LazyVimConfig.json.load()

	-- Add lua/*/plugins/extras as list of "extra" sources
	LazyVim.extras.sources = {
		-- {
		-- 	name = 'LazyVim',
		-- 	desc = 'LazyVim extras',
		-- 	module = 'lazyvim.plugins.extras',
		-- },
		{
			name = 'Skogix ',
			desc = 'Skogix extras',
			module = 'skogix.plugins.extras',
		},
		{
			name = 'User ',
			desc = 'User extras',
			module = 'plugins.extras',
		},
	}

end

return M
