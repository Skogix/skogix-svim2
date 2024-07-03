	-- {
	-- 	'someone-stole-my-name/yaml-companion.nvim',
	-- 	dependencies = {
	-- 		'neovim/nvim-lspconfig',
	-- 		'nvim-telescope/telescope.nvim',
	-- 	},
	-- 	keys = {
	-- 		-- stylua: ignore
	-- 		{ '<localleader>y', '<cmd>Telescope yaml_schema<CR>', desc = 'YAML Schema' },
	-- 	},
	-- 	opts = {},
	-- 	config = function(_, _)
	-- 		require('telescope').load_extension('yaml_schema')
	-- 	end,
	-- },
return {
		{
	"tiagovla/scope.nvim",
		}
		,{
	"nvim-telescope/telescope.nvim",

		config = function(_, _)
			require('telescope').load_extension('scope')
		end,
}}
