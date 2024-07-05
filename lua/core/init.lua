--- This script is responsible for setting up the LazyVim environment.
--- It clones necessary repositories if they are not already installed.
--- It also loads user options from a specific setup file and checks if certain plugin files exist.
--- Finally, it sets up the LazyVim environment with a specific configuration.

-- Clone bootstrap repositories if not already installed.
local function clone(remote, dest)
  -- If the destination does not exist, clone the repository from the remote URL.
  -- The repository is cloned with the 'blob:none' filter and the 'stable' branch.
  -- The remote URL is constructed by appending the remote to the GitHub base URL.
  if not vim.uv.fs_stat(dest) then
    print("Installing " .. dest .. "…")
    remote = "https://github.com/" .. remote
    -- stylua: ignore
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', remote, '--branch=stable', dest })
  end
end

-- Define the path for the lazy.nvim repository and clone it.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
clone("folke/lazy.nvim.git", lazypath)

-- Prepend the runtime path with the path to the lazy.nvim repository.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Clone the LazyVim repository.
clone("LazyVim/LazyVim.git", vim.fn.stdpath("data") .. "/lazy/LazyVim")

-- Load user options from lua/config/setup.lua
-- If the setup file exists and contains a 'lazy_opts' field, its value is used.
-- Otherwise, an empty table is used.
local user_lazy_opts = {}
-- local ok, user_setup = pcall(require, "skogix.config.setup")
-- if ok and user_setup.lazy_opts then
--   user_lazy_opts = user_setup.lazy_opts() or {}
-- end

-- Validate if lua/plugins/ or lua/plugins.lua exist.
-- If either file exists, 'has_user_plugins' is set to true.
-- local user_path = vim.fn.stdpath("config") .. "/lua"
-- print(user_path)
-- local has_user_plugins = vim.uv.fs_stat(user_path .. "/plugins") ~= nil
--     or vim.uv.fs_stat(user_path .. "/plugins.lua") ~= nil

-- Set up the LazyVim environment.
-- The 'spec' field defines the plugins to be loaded.
-- Other commented fields can be uncommented to customize the setup.
-- require("lazy").setup({
require("lazy").setup(vim.tbl_extend('keep', user_lazy_opts,{
	spec = require('core.imports'),
	-- require("init").INPUT,
	concurrency = vim.uv.available_parallelism() * 2,
	defaults = { lazy = false, version = false },
	-- dev = { path = vim.fn.stdpath("config") .. "/dev" },
	install = { missing = true, colorscheme = {"gruvbox"} },
	--checker = { enabled = true, notify = false },
	change_detection = { notify = false },
	ui = { border = "rounded" },
	diff = { cmd = "terminal_git" },
	pkg = {
		enabled = true,
		cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
		versions = true, -- Honor versions in pkg sources
		-- the first package source that is found for a plugin will be used.
		sources = {
			"lazy",
			"rockspec",
			"packspec",
		},
	},
	rocks = {
		root = vim.fn.stdpath("data") .. "/lazy-rocks",
		server = "https://nvim-neorocks.github.io/rocks-binaries/",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"vimballPlugin",
				"matchit",
				"matchparen",
				"2html_plugin",
				"tarPlugin",
				"netrwPlugin",
				"tutor",
				"zipPlugin",
			},
		},
	},
}))
