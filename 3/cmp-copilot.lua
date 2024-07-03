
	return {
		"hrsh7th/nvim-cmp",
		dependencies = {
			"zbirenbaum/copilot-cmp",
		},
		opts = function(_, opts)
			table.insert(opts.sources, { name = "copilot-cmp", group_index = 2, priority = 80,keyword_length = 1 })
		end,
	}
