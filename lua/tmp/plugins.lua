-- local enabled = require("core.utils.utils").enabled
--
-- local exist, user_config = pcall(require, "user.user_config")
-- local group = exist and type(user_config) == "table" and user_config.enable_plugins or {}
-- local plugins = exist and type(user_config) == "table" and user_config.plugins or {}
-- require("lazy").setup({
return {
	{
		"stevearc/aerial.nvim",
		cmd = "AerialToggle",
		config = function()
			require("plugin-configs.aerial")
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("plugin-configs.alpha")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		config = function()
			require("plugin-configs.bufferline")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.dressing")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("plugin-configs.gitsigns")
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		event = "VimEnter",
		config = function()
			require("plugin-configs.hop")
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VimEnter",
		branch = "v3.x",
		config = function()
			require("plugin-configs.lsp")
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({buffer = bufnr})
			end)
		end,
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
	},
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.neodev")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.neoscroll")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.neo-tree")
		end,
		branch = "v3.x",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"Shatur/neovim-session-manager",
		event = "VimEnter",
		config = function()
			require("plugin-configs.session")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("plugin-configs.noice")
		end,
		dependencies = { { "MunifTanjim/nui.nvim" } },
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugin-configs.null-ls")
		end,
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				config = function()
					require("plugin-configs.mason-null-ls")
				end,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugin-configs.autopairs")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugin-configs.cmp")
		end,
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			require("plugin-configs.dap")
		end,
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				config = function()
					require("plugin-configs.mason-nvim-dap")
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("dapui").setup()
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
			{
				"nvim-neotest/nvim-nio",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
	},
	{
		"kylechui/nvim-surround",
		event = "VimEnter",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugin-configs.treesitter")
		end,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("plugin-configs.treesitter-context")
				end,
			},
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VimEnter",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup()
		end,
	},
	{
		"navarasu/onedark.nvim",
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"ahmedkhalf/project.nvim",
		event = "VimEnter",
		config = function()
			require("project_nvim").setup()
		end,
	},
	{
		"tiagovla/scope.nvim",
		event = "VimEnter",
		config = function()
			require("plugin-configs.scope")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("plugin-configs.telescope")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			_G.term = require("plugin-configs.toggleterm")
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
	},
	{
		"folke/twilight.nvim",
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		config = function()
			require("plugin-configs.twilight")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		"windwp/windline.nvim",
		event = "VeryLazy",
		config = function()
			require("wlsample.evil_line")
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("plugin-configs.zenmode")
		end,
	},
	-- plugins,
}
-- , {
-- 	defaults = { lazy = true },
-- 	performance = {
-- 		rtp = {
-- 			disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
-- 		},
-- 	},
-- })
