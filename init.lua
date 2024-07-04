-- require('skogix.config.lazy')
-- Define the path to the standard configuration
-- local stdPath = vim.fn.stdpath("data")

-- Define the path to the lazy configuration override
-- local stdpathLazyNvim = stdPath .. '/lazy/lazy.nvim'
-- local stdpathLazyNvimConfig = stdpathLazyNvim .. '/lua/config/lazy.lua'
-- $stdpath:/home/skogix/.local/share/svim
--.. '/lua/config/lazy.lua'
--/lazy/lazy.nvim
-- print("$stdpath:" .. stdPath)
-- print("$stdpathLazyNvim:" .. stdpathLazyNvim)
-- print("$stdpathLazyNvimConfig:" .. stdpathLazyNvimConfig)

-- Use the existing event loop or initialize a new one
-- vim.eventLoop = vim.eventLoop or vim.loop

-- require('/home/skogix/.local/share/svim/lazy/lazy.nvim/lua/lazy/core/config.lua')

require("skogix.config.lazy")

-- Check if the lazy configuration override file exists
-- if vim.eventLoop.fs_stat(stdpathLazyNvimConfig) then
-- If the override file exists, load it to override the default configuration
-- require('dev.config.lazy')
-- 	require('lazy.config')
-- else
-- If the override file does not exist, load the default configuration
-- end
-- require('skogix.config.lazy')
