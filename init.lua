






-- Define the path to the standard configuration
local standardConfigurationPath = vim.fn.stdpath('config')

-- Define the path to the lazy configuration override
local lazyConfigurationOverridePath = standardConfigurationPath .. '/lua/config/azy.lua'

-- Use the existing event loop or initialize a new one
vim.eventLoop = vim.eventLoop or vim.loop

-- Check if the lazy configuration override file exists
if vim.eventLoop.fs_stat(lazyConfigurationOverridePath) then
	-- If the override file exists, load it to override the default configuration
	require('config.lazy')
else
	-- If the override file does not exist, load the default configuration
	require('skogix.config.lazy')
end
