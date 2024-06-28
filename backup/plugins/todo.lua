	-----------------------------------------------------------------------------
	-- Highlight, list and search todo comments in your projects
	return {
		'folke/todo-comments.nvim',
		event = 'LazyFile',
		dependencies = { 'nvim-lua/plenary.nvim' },
		-- stylua: ignore
		keys = {
			{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next Todo Comment' },
			{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous Todo Comment' },
			{ '<leader>xt', '<cmd>TodoTrouble<CR>', desc = 'Todo (Trouble)' },
			{ '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
			{ '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
		},
		opts = { signs = false },
	}
