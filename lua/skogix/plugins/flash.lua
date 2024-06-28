	-----------------------------------------------------------------------------
	-- Search labels, enhanced character motions
return {
		'folke/flash.nvim',
		event = 'VeryLazy',
		vscode = true,
		---@diagnostic disable-next-line: undefined-doc-name
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					enabled = false,
				},
			},
		},
		-- stylua: ignore
		-- keys = {
		-- 	{ 'ss', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
		-- 	{ 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
		-- 	{ 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
		-- 	{ 'R', mode = { 'x', 'o' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
		-- 	{ '<C-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
		-- },
	}
