local standardConfigPath = vim.fn.stdpath('config')
local lazyConfigOverridePath = standardConfigPath .. '/lua/config/lazy.lua'

vim.eventLoop = vim.eventLoop or vim.loop

if vim.eventLoop.fs_stat(lazyConfigOverridePath) then
	-- Override Skogix default config.
	require('config.lazy')
else
	-- Bootstrap lazy.nvim, SVim, LazyVim and your plugins.
	require('skogix.config.lazy')
end
