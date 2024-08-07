-- Clone bootstrap repositories if not already installed.
local function clone(remote, dest)
	if not vim.uv.fs_stat(dest) then
		print("Installing " .. dest .. "…")
		remote = "https://github.com/" .. remote
		-- stylua: ignore
		vim.fn.system({ 'git', 'clone', '--filter=blob:none', remote, '--branch=stable', dest })
	end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
clone("folke/lazy.nvim.git", lazypath)
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
clone("LazyVim/LazyVim.git", vim.fn.stdpath("data") .. "/lazy/LazyVim")

-- Load user options from lua/config/setup.lua
local user_lazy_opts = {}
local ok, user_setup = pcall(require, "config.setup")
if ok and user_setup.lazy_opts then
	user_lazy_opts = user_setup.lazy_opts() or {}
end

-- Validate if lua/plugins/ or lua/plugins.lua exist.
local user_path = vim.fn.stdpath("config") .. "/lua"
local has_user_plugins = vim.uv.fs_stat(user_path .. "/plugins") ~= nil
    or vim.uv.fs_stat(user_path .. "/plugins.lua") ~= nil

-- Start lazy.nvim plugin manager.
require("lazy").setup(vim.tbl_extend("keep", user_lazy_opts, {
	spec = {
		{ import = "skogix.plugins.lazyvim" },
		{ import = "skogix.plugins" },
		-- { import = "skogix.keymaps" },
		-- { import = "skogix.plugins.todo" },
		-- { import = "skogix.plugins.init" },
		-- { import = "skogix.plugins.lsp" },
		-- { import = "skogix.plugins.cmp" },
		-- { import = "skogix.plugins.neo-tree" },
		-- { import = "skogix.plugins.treesitter" },
		-- { import = "skogix.plugins.telescope" },
		-- { import = "skogix.plugins.which-key" },
		-- { import = "skogix.plugins.harpoon" },
		-- { import = "skogix.plugins.git" },
		-- { import = "skogix.plugins.colorscheme" },
		-- { import = "skogix.plugins.neorg" },
		{ import = "lazyvim.plugins.xtras" },
		has_user_plugins and { import = "plugins" } or nil,
	},
	concurrency = vim.uv.available_parallelism() * 2,
	defaults = { lazy = true, version = false },
	dev = { path = vim.fn.stdpath("config") .. "/dev" },
	install = { missing = true, colorscheme = {} },
	checker = { enabled = true, notify = false },
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
