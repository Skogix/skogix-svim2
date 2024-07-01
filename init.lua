


local stdconfig = vim.fn.stdpath('config')
local lazy_override = stdconfig .. '/lua/config/lazy.lua'

vim.uv = vim.uv or vim.loop

if vim.uv.fs_stat(lazy_override) then
	-- Override Skogix default config.
	require('config.lazy')
else
	-- Bootstrap lazy.nvim, SVim, LazyVim and your plugins.
	require('skogix.config.lazy')
end
