-- Plugins initialization

if vim.fn.has("nvim-0.9.0") == 0 then
	vim.api.nvim_echo({
		{ "Upgrade to Neovim >= 0.10.0 for the best experience.\n", "ErrorMsg" },
		{ "Press any key to exit", "MoreMsg" },
	}, true, {})
	vim.fn.getchar()
	vim.cmd([[quit]])
	return {}
end

require("core.config").init()

return {
	-- Modern plugin manager for Neovim
	{ "folke/lazy.nvim", version = "*" },
	-- Lua functions library
	{ "nvim-lua/plenary.nvim", lazy = false },
	-- { import = "core.lazyvim" },
	{ "nvim-lua/plenary.nvim", lazy = false },
	{
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"windwp/nvim-ts-autotag",
			},
			opts = {
				ensure_installed = {
					"bash",
					"regex",
					"vim",
					"lua",
					"html",
					"markdown",
					"markdown_inline",
					"css",
					"typescript",
					"tsx",
					"javascript",
					"hurl",
					"json",
					"json5",
					"jsonc",
					"graphql",
					"prisma",
					"rust",
					"go",
					"toml",
					"c",
					"proto",
					"svelte",
					"astro",
					"embedded_template",
				},
				auto_install = true,
				-- ensure_installed = "all", -- one of "all" or a list of languages
				ignore_install = { "" }, -- List of parsers to ignore installing
				sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

				highlight = {
					enable = true, -- false will disable the whole extension
					disable = { "css" }, -- list of language that will be disabled
				},
				autopairs = {
					enable = true,
				},
				indent = { enable = true, disable = { "python", "css" } },

				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},

				-- auto tag
				autotag = {
					enable = true,
				},
			},
		},
	},
	{"folke/which-key.nvim"},
}
