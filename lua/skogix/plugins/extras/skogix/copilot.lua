return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestion = { enabled = true },
				auto_trigger = { enabled = false },
				filetypes = {
					markdown = true, -- overrides default
					terraform = false, -- disallow specific filetype
					["*"] = true,
					sh = function ()
						if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
							-- disable for .env files
							return false
						end
						return true
					end,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		opts = function ()
			require("copilot_cmp").setup()
		end
	},
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    config = function()
      local opts = require "skogix.plugins.extras.skogix.cmp"
      -- local opts = require("copilot_cmp")
      require("cmp").setup(opts)
    end
  },
}
