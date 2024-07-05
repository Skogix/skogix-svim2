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

require("user.globals")
require("user.keymaps").setup()
require("user.autocommands")

require("user.change_cwd")
require("user.find_where_included")
require("user.diagnostics")
require("core")
require("user")
-- Check if the lazy configuration override file exists
-- if vim.eventLoop.fs_stat(stdpathLazyNvimConfig) then
-- If the override file exists, load it to override the default configuration
-- require('dev.config.lazy')
-- 	require('lazy.config')
-- else
-- If the override file does not exist, load the default configuration
-- end
-- require('skogix.config.lazy')

--
-- -- Define the path to the standard configuration
-- local standardConfigurationPath = vim.fn.stdpath('config')
--
-- -- Define the path to the lazy configuration override
-- local lazyConfigurationOverridePath = standardConfigurationPath .. '/lua/config/lazy.lua'
--
-- -- Use the existing event loop or initialize a new one
-- vim.eventLoop = vim.eventLoop or vim.loop
--
-- -- Check if the lazy configuration override file exists
-- if vim.eventLoop.fs_stat(lazyConfigurationOverridePath) then
-- 	-- If the override file exists, load it to override the default configuration
-- 	require('config.lazy')
-- else
-- 	-- If the override file does not exist, load the default configuration
-- 	require('skogix.config.lazy')
-- end
-- >>>>>>> theirs
-- =======
-- local stdconfig = vim.fn.stdpath('config')
-- local lazy_override = stdconfig .. '/lua/config/lazy.lua'
--
-- vim.uv = vim.uv or vim.loop
--
-- if vim.uv.fs_stat(lazy_override) then
-- 	-- Override Skogix default config.
-- 	require('config.lazy')
-- else
-- 	-- Bootstrap lazy.nvim, SVim, LazyVim and your plugins.
-- 	require('skogix.config.lazy')
-- end
-- >>>>>>> feature/rafi
