return {
	'nvim-neorg/neorg',
	version = '^8',
	dependencies = {'nvim-neorg/neorg-telescope'},
	lazy = false,
	event = 'VeryLazy',
	ft = 'norg',
	opts = {
		load = {
			['core.defaults'] = {},        -- Loads default behaviour
			['core.summary'] = {},         -- Loads default behaviour
			['core.export'] = {},          -- Loads default behaviour
			['core.export.markdown'] = {}, -- Loads default behaviour
			['core.concealer'] = {},       -- Adds pretty icons to your documents
			['core.keybinds'] = {
				config = {
					default_keybinds = false,
					hook = function(keybinds)
						require('skogix.keymaps.neorg').setup(keybinds)
					end,
				},
			},                         -- Adds default keybindings
			['core.ui.calendar'] = {}, -- Adds default keybindings
			['core.completion'] = { config = { engine = 'nvim-cmp', }, }, -- Enables support for completion plugins
			['core.integrations.nvim-cmp'] = {},
			['core.integrations.telescope'] = {},
			['core.journal'] = {}, -- Enables support for the journal module
			['core.dirman'] = {    -- Manages Neorg workspaces
				config = {
					workspaces = {
						skogix = '/home/skogix/org/neorg/skogix',
						work = '/home/skogix/org/neorg/work',
						svim = '/home/skogix/.config/nvim',
					},
					index = 'index.norg',
					default_workspace = 'skogix',
				},
			},
		},
	},


	{ 
		'nvim-neorg/neorg-telescope',
		dependencies = { "nvim-neorg/neorg-telescope" },
		config = function()
			require('neorg-telescope').setup()
			require('telescope').load_extension("neorg-telescope")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
}
