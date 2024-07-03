return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	init = function()
		-- disable until lualine loads
		vim.opt.laststatus = 0
	end,
	config = {
		options = {
			icons_enabled = true,
			theme = cozynight,
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = {},
			always_divide_middle = true
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff',
				{
					'diagnostics',
					sources = { "nvim_diagnostic" },
					symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
				}
			},
			lualine_c = { 'filename' },
			lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' }, -- I added copilot here
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		extensions = {}
	},
	opts = true,
}
