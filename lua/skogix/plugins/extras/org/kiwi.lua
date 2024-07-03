-- rafi.plugins.extras.org.wiki
--

return {

	-- Stripped down VimWiki
	{
		'serenevoid/kiwi.nvim',
		keys = {
			{ '<leader>zo', function() require('kiwi').open_wiki_index() end, desc = 'Open wiki' },
			{ '<leader>zd', function() require('kiki').open_diary_index() end, desc = 'Diary index' },
			{ '<leader>zn', function() require('kiki').open_diary_new() end, desc = 'Diary new' },
			{ '<leader>zx', function() require('kiki').todo.toggle() end, desc = 'Toggle todo' },
		},
	},
}
