return
	{
		"nvim-neorg/neorg",
		build = false,
		-- lazy-load on filetype
		ft = "norg",
		event = 'VeryLazy',
		-- options for neorg. This will automatically call `require("neorg").setup(opts)`
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
							local leader = keybinds.leader
							-- local whichkey = require 'which-key'
							-- whichkey.register({
							--   ['<localleader>'] = {
							--     name = '[Neorg] mode',
							--     m = { name = '[Neorg] mode' },
							--   },
							--   ['<leader>'] = {
							--     w = {
							--       name = 'notes',
							--       w = { '<cmd>VimwikiIndex<cr><cmd>VimwikiGenerateLinks<cr><cmd>VimwikiGenerateTagLinks<cr>', 'wiki' },
							--       n = { '<cmd>Neorg index<cr>', 'neorg' },
							--     },
							--   },
							-- }, {})
							-- Map all the below keybinds only when the "norg" mode is active
							keybinds.map('norg', 'n', 'sk', '<cmd>Neorg keybind all<cr>', { desc = 'neorg' })
							keybinds.map(
								'norg',
								'n',
								'<localleader>c',
								'<cmd>Neorg keybind all core.dirman.new.note<cr><cmd>Neorg inject-metadata<cr>',
								{ desc = '[neorg] create note' }
							)
							keybinds.map(
								'norg',
								'n',
								'<localleader><localleader>',
								'<cmd>Neorg update-metadata<cr><cmd>w<cr><cmd>Neorg index<cr>',
								{ desc = '[neorg] save; index' }
							)
							-- keybinds.map('norg', 'n', 'ss', '<cmd>Neorg keybind all core.dirman.new.note<cr>', { desc = 'neorg' })
							keybinds.map('norg', 'n', '<localleader>m', 'which_key_ignore', { desc = 'neorg' })
							keybinds.map_event_to_mode('norg', {
								n = {
									-- Switches the task under the cursor between a select few states
									{ '<C-Space>', 'core.qol.todo_items.todo.task_cycle',         opts = { desc = '[neorg] Cycle Task' } },

									-- Creates a new .norg file to take notes in
									-- { leader .. 'c', 'core.dirman.new.note', opts = { desc = '[neorg] create new note' } },
									{ 'ss',        'core.integrations.telescope.find_norg_files', opts = { desc = '[neorg] search neorg files' } },
									-- { 'ss', 'core.integrations.telescope.find_norg_files', opts = { desc = '[neorg] search neorg files' } },

									-- Hop to the destination of the link under the cursor
									{ '<CR>',      'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
									{ 'gd',        'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
									{ 'gf',        'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
									{ 'gF',        'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },

									-- Same as `<CR>`, except opens the destination in a vertical split
									{ '<C-CR>',    'core.esupports.hop.hop-link',                 'vsplit',                                                    opts = { desc = '[neorg] Jump to Link (Vertical Split)' } },

									-- Promote
									{ '>.',        'core.promo.promote',                          opts = { desc = '[neorg] Promote Object (Non-Recursively)' } },
									{ '<,',        'core.promo.demote',                           opts = { desc = '[neorg] Demote Object (Non-Recursively)' } },

									{ '>>',        'core.promo.promote',                          'nested',                                                    opts = { desc = '[neorg] Promote Object (Recursively)' } },
									{ '<<',        'core.promo.demote',                           'nested',                                                    opts = { desc = '[neorg] Demote Object (Recursively)' } },

									-- { leader .. 'lt', 'core.pivot.toggle-list-type', opts = { desc = '[neorg] Toggle (Un)ordered List' } },
									-- { leader .. 'li', 'core.pivot.invert-list-type', opts = { desc = '[neorg] Invert (Un)ordered List' } },

									-- { leader .. 'id', 'core.tempus.insert-date', opts = { desc = '[neorg] Insert Date' } },
								},

								i = {
									{ '<C-t>', 'core.promo.promote',                  opts = { desc = '[neorg] Promote Object (Recursively)' } },
									{ '<C-d>', 'core.promo.demote',                   opts = { desc = '[neorg] Demote Object (Recursively)' } },
									-- { '<C-CR>', 'core.itero.next-iteration', '<CR>', opts = { desc = '[neorg] Continue Object' } },
									{ '<M-d>', 'core.tempus.insert-date-insert-mode', opts = { desc = '[neorg] Insert Date' } },
								},
							}, {
									silent = true,
									noremap = true,
								})

							-- Map the below keys only when traverse-heading mode is active
							keybinds.map_event_to_mode('traverse-heading', {
								n = {
									-- Move to the next heading in the document
									{
										'j',
										'core.integrations.treesitter.next.heading',
										opts = { desc = '[neorg] Move to Next Heading' },
									},

									-- Move to the previous heading in the documenc
									{
										'k',
										'core.integrations.treesitter.previous.heading',
										opts = { desc = '[neorg] Move to Previous Heading' },
									},
								},
							}, {
									silent = true,
									noremap = true,
								})

							-- Map the below keys only when traverse-link mode is active
							keybinds.map_event_to_mode('traverse-link', {
								n = {
									-- Move to the next link in the document
									{ 'j', 'core.integrations.treesitter.next.link', opts = { desc = '[neorg] Move to Next Link' } },

									-- Move to the previous link in the document
									{
										'k',
										'core.integrations.treesitter.previous.link',
										opts = { desc = '[neorg] Move to Previous Link' },
									},
								},
							}, {
									silent = true,
									noremap = true,
								})

							-- Map the below keys on presenter mode
							keybinds.map_event_to_mode('presenter', {
								n = {
									{ '<CR>',  'core.presenter.next_page',     opts = { desc = '[neorg] Next Page' } },
									{ 'l',     'core.presenter.next_page',     opts = { desc = '[neorg] Next Page' } },
									{ 'h',     'core.presenter.previous_page', opts = { desc = '[neorg] Previous Page' } },

									-- Keys for closing the current display
									{ 'q',     'core.presenter.close',         opts = { desc = '[neorg] Close Presentation' } },
									{ '<Esc>', 'core.presenter.close',         opts = { desc = '[neorg] Close Presentation' } },
								},
							}, {
									silent = true,
									noremap = true,
									nowait = true,
								})

							-- Apply the below keys to all modes
							keybinds.map_to_mode('all', {
								n = {
									{ leader .. 'm',  '',                         opts = { desc = '[neorg] Norg Mode' } },
									{ leader .. 'mn', '<cmd>Neorg mode norg<CR>', opts = { desc = '[neorg] Enter Norg Mode' } },
									{
										leader .. 'mh',
										'<cmd>Neorg mode traverse-heading<CR>',
										opts = { desc = '[neorg] Enter Heading Traversal Mode' },
									},
									{
										leader .. 'ml',
										'<cmd>Neorg mode traverse-link<CR>',
										opts = { desc = '[neorg] Enter Link Traversal Mode' },
									},
									{ 'gO', '<cmd>Neorg toc split<CR>', opts = { desc = '[neorg] Open a Table of Contents' } },
								},
							}, {
									silent = true,
									noremap = true,
								})
						end,
					},
				},                         -- Adds default keybindings
				['core.ui.calendar'] = {}, -- Adds default keybindings
				['core.completion'] = {
					config = {
						engine = 'nvim-cmp',
					},
				}, -- Enables support for completion plugins
				['core.integrations.nvim-cmp'] = {},
				['core.integrations.telescope'] = {},
				['core.journal'] = {}, -- Enables support for the journal module
				['core.dirman'] = {    -- Manages Neorg workspaces
					config = {
						workspaces = {
							skogix = '/home/skogix/org/neorg/skogix',
							work = '/home/skogix/org/neorg/work',
							nvim = '/home/skogix/.config/skogix'
						},
						index = 'index.norg',
						default_workspace = 'skogix',
					},
				},
			},
		},
}
