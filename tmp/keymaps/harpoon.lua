return {
		"<leader>ht",
		function()
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		desc = "[harpoon] toggle menu",
	},
	{
		"<leader>hm",
		function()
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		desc = "[harpoon] toggle menu",
	},

	{
		"<leader>ha",
		function()
			local harpoon = require("harpoon")
			harpoon:list():add()
		end,
		desc = "[harpoon] add file",
	},
	{
		"<leader>hn",
		function()
			local harpoon = require("harpoon")
			harpoon:list():next()
		end,
		desc = "[harpoon] next",
	},
	{
		"<leader>hh",
		function()
			local harpoon = require("harpoon")
			harpoon:list():next()
		end,
		desc = "[harpoon] next",
	},
	{
		"<leader>hl",
		function()
			local harpoon = require("harpoon")
			harpoon:list():prev()
		end,
		desc = "[harpoon] prev",
	}
}
