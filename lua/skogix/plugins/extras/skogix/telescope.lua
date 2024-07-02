--- Open selected file in vertical split
local function open_selected_file_in_vertical()
	local entry = require("telescope.actions.state").get_selected_entry()
	require("telescope.actions").close(entry)
	vim.cmd("vsplit " .. entry.path)
end

-- -- Telescope integration
-- local addToWhichKey, _ = pcall(require, "which-key")
-- local function add_to_which_key()
-- 	if addToWhichKey then
-- 		print("added to whichkey")
-- 		local wk = require('which-key')
-- 		wk.register({s = {name="[search]"}},{})
-- 	else
-- 		print("!!!!!!!!!!!!!!!!11")
-- 	end
-- end

return {
    "nvim-telescope/telescope.nvim",
		-- lazy = false,
		event = 'VimEnter',
    config = {
      defaults = {
				cache_picker = { num_pickers = 3 },

				prompt_prefix = '  ', -- ❯  
				selection_caret = '▍ ',
				multi_icon = ' ',

				path_display = { 'truncate' },
				file_ignore_patterns = { 'node_modules' },
				set_env = { COLORTERM = 'truecolor' },
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    },
			pickers = {
				find_files = {
					layout_config = { preview_width = 0.5 },
				},
				live_grep = {
					dynamic_preview_title = true,
				},
				colorscheme = {
					enable_preview = true,
					layout_config = { preview_width = 0.7 },
				},
				highlights = {
					layout_config = { preview_width = 0.7 },
				},
				vim_options = {
					theme = 'dropdown',
				},
				command_history = {
					theme = 'dropdown',
				},
				search_history = {
					theme = 'dropdown',
				},
				spell_suggest = {
					theme = 'cursor',
				},
				registers = {
					theme = 'cursor',
				},
				oldfiles = {
					theme = 'dropdown',
					previewer = false,
				},
				lsp_definitions = {
				},
				lsp_implementations = {
				},
				lsp_references = {
				},
				lsp_code_actions = {
					theme = 'cursor',
					previewer = false,
					layout_config = { width = 0.3, height = 0.4 },
				},
				lsp_range_code_actions = {
					theme = 'cursor',
					previewer = false,
					layout_config = { width = 0.3, height = 0.4 },
				},
			},
			keys = {
				{
					"ss",
					"<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
					desc = "[search] all files",
				},
				{
					"sg",
					"<cmd> Telescope  live_grep<CR>",
					desc = "[search] grep text",
				},
			},
			mapping = {
				i = {
					["C-v"] = open_selected_file_in_vertical,
				},
			},
		}
