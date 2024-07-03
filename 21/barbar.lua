
local Keymaps = {

	-- map('n', 'sb', '<cmd>buffer#<CR>', { 'Alternate buffer' })
	-- map('n', 'sc', '<cmd>close<CR>', { 'Close window' })
	-- map('n', 'sd', '<cmd>bdelete<CR>', { 'Buffer delete' })
	-- map('n', 'sv', '<cmd>split<CR>', { 'Split window horizontally' })
	-- map('n', 'sg', '<cmd>vsplit<CR>', { 'Split window vertically' })
	-- map('n', 'st', '<cmd>tabnew<CR>', { 'New tab' })
	-- map('n', 'so', '<cmd>only<CR>', { 'Close other windows' })
	-- map('n', 'sq', '<cmd>quit<CR>', { 'Quit' })

	-- -- Move to previous/next
	{ 'H',         '<Cmd>BufferPrevious<CR>',                   desc = "[buffer] prev" },
	{ 'L',         '<Cmd>BufferNext<CR>',                       desc = "[buffer] next" },
	-- -- Re-order to previous/next
	{ '<A-h>',     '<Cmd>BufferMovePrevious<CR>',               desc = "[buffer] move prev" },
	{ '<A-l>',     '<Cmd>BufferMoveNext<CR>',                   desc = "[buffer] move next" },
	-- -- Goto buffer in position...
	{ '<A-1>',     '<Cmd>BufferGoto 1<CR>',                     desc = "[buffer] goto 1" },
	{ '<A-2>',     '<Cmd>BufferGoto 2<CR>',                     desc = "[buffer] goto 2" },
	{ '<A-3>',     '<Cmd>BufferGoto 3<CR>',                     desc = "[buffer] goto 3" },
	{ '<A-4>',     '<Cmd>BufferGoto 4<CR>',                     desc = "[buffer] goto 4" },
	{ '<A-5>',     '<Cmd>BufferGoto 5<CR>',                     desc = "[buffer] goto 5" },
	{ '<A-6>',     '<Cmd>BufferGoto 6<CR>',                     desc = "[buffer] goto 6" },
	{ '<A-7>',     '<Cmd>BufferGoto 7<CR>',                     desc = "[buffer] goto 7" },
	{ '<A-8>',     '<Cmd>BufferGoto 8<CR>',                     desc = "[buffer] goto 8" },
	{ '<A-9>',     '<Cmd>BufferGoto 9<CR>',                     desc = "[buffer] goto 9" },
	{ '<A-0>',     '<Cmd>BufferLast<CR>',                       desc = "[buffer] goto last" },
	-- -- Pin/unpin buffer
	{ '<A-p>',     '<Cmd>BufferPin<CR>',                        desc = "[buffer] pin" },
	-- -- Close buffer
	{ '<S-w>',     '<Cmd>BufferClose<CR>',                      desc = "[buffer] close" },
	{ '<C-c>',     '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', desc = "[buffer] close all but current or pinned" },
	-- --                 :BufferCloseAllButCurrentOrPinned
	-- -- Wipeout buffer
	-- --                 :BufferWipeout
	-- -- Close commands
	-- --                 :BufferCloseAllButCurrent
	-- --                 :BufferCloseAllButPinned
	-- --                 :BufferCloseAllButCurrentOrPinned
	-- --                 :BufferCloseBuffersLeft
	-- --                 :BufferCloseBuffersRight
	-- -- Magic buffer-picking mode
	{ '<C-p>',     '<Cmd>BufferPick<CR>',                       desc = "[buffer] pick" },
	-- -- Sort automatically by...
	{ '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>',        desc = "[buffer] order by buffer number" },
	{ '<Space>bn', '<Cmd>BufferOrderByName<CR>',                desc = "[buffer] order by name" },
	{ '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>',           desc = "[buffer] order by directory" },
	{ '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>',            desc = "[buffer] order by language" },
	{ '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>',        desc = "[buffer] order by window number" },
}
return Keymaps
