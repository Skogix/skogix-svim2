	-- local leader = keybinds.leader

local M = {}

function M.globals(wk)
	wk.register({
		['<leader>'] = {
			n = {
				name = 'neorg',
				w = { '<cmd>Neorg workspace work<CR>', '[neorg] work' },
				s = { '<cmd>Neorg workspace work<CR>', '[neorg] skogix' },
				v = { '<cmd>Neorg workspace work<CR>', '[neorg] svim' },
				N = { '<cmd>Neorg index<cr>', '[neorg] neorg' },
				n = { '<cmd>Neorg keybinds core.dirman.new.note<CR>', '[neorg] new note' },
			},
			w = {
				name = 'notes',
				W = { '<cmd>VimwikiIndex<cr><cmd>VimwikiGenerateLinks<cr><cmd>VimwikiGenerateTagLinks<cr>', 'wiki' },
			},
		},
		['<localleader>'] = {
			name = '[Neorg] mode',
			m = { name = '[Neorg] mode' },
		},
		}, {})
end


function Keybinds(keybinds)
	keybinds.map('norg', 'n', '<localleader>n', '<cmd>test<cr>', { desc = 'My description' })
	keybinds.map('norg', 'n', '<localleader>N', '<cmd>test<cr>', { desc = 'My description' })
	keybinds.map('norg', 'n', 'sk', '<cmd>Neorg keybind all<cr>', { desc = 'neorg' })
	keybinds.map('norg', 'n', '<localleader>c', '<cmd>Neorg keybind all core.dirman.new.note<cr><cmd>Neorg inject-metadata<cr>', { desc = '[neorg] create note' } )
	keybinds.map('norg', 'n', '<localleader><localleader>', '<cmd>Neorg update-metadata<cr><cmd>w<cr><cmd>Neorg index<cr>', { desc = '[neorg] save; index' } )
	keybinds.map('norg', 'n', 'ss', '<cmd>Neorg keybind all core.dirman.new.note<cr>', { desc = 'neorg' })
	keybinds.map('norg', 'n', '<localleader>m', 'which_key_ignore', { desc = 'neorg' })
end


keybinds.map_event_to_mode('norg', {
	n = {
		{ '<C-Space>', 'core.qol.todo_items.todo.task_cycle',         opts = { desc = '[neorg] Cycle Task' } },
		{ leader .. 'c', 'core.dirman.new.note', opts = { desc = '[neorg] create new note' } },
		{ 'ss', 'core.integrations.telescope.find_norg_files', opts = { desc = '[neorg] search neorg files' } },
		{ 'ss', 'core.integrations.telescope.find_norg_files', opts = { desc = '[neorg] search neorg files' } },
		{ '<CR>',      'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
		{ 'gd',        'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
		{ 'gf',        'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
		{ 'gF',        'core.esupports.hop.hop-link',                 opts = { desc = '[neorg] Jump to Link' } },
		{ '<C-CR>',    'core.esupports.hop.hop-link',                 'vsplit',                                                    opts = { desc = '[neorg] Jump to Link (Vertical Split)' } },
		{ '>.',        'core.promo.promote',                          opts = { desc = '[neorg] Promote Object (Non-Recursively)' } },
		{ '<,',        'core.promo.demote',                           opts = { desc = '[neorg] Demote Object (Non-Recursively)' } },
		{ '>>',        'core.promo.promote',                          'nested',                                                    opts = { desc = '[neorg] Promote Object (Recursively)' } },
		{ '<<',        'core.promo.demote',                           'nested',                                                    opts = { desc = '[neorg] Demote Object (Recursively)' } },
		{ leader .. 'lt', 'core.pivot.toggle-list-type', opts = { desc = '[neorg] Toggle (Un)ordered List' } },
		{ leader .. 'li', 'core.pivot.invert-list-type', opts = { desc = '[neorg] Invert (Un)ordered List' } },
		{ leader .. 'id', 'core.tempus.insert-date', opts = { desc = '[neorg] Insert Date' } },
	},
	i = {
		{ '<C-t>', 'core.promo.promote',                  opts = { desc = '[neorg] Promote Object (Recursively)' } },
		{ '<C-d>', 'core.promo.demote',                   opts = { desc = '[neorg] Demote Object (Recursively)' } },
		{ '<C-CR>', 'core.itero.next-iteration', '<CR>', opts = { desc = '[neorg] Continue Object' } },
		{ '<M-d>', 'core.tempus.insert-date-insert-mode', opts = { desc = '[neorg] Insert Date' } },
	},
	}, {
		silent = true,
		noremap = true,
})

-- Map the below keys only when traverse-heading mode is active
keybinds.map_event_to_mode('traverse-heading', {
	n = {
		{ 'j', 'core.integrations.treesitter.next.heading', opts = { desc = '[neorg] Move to Next Heading' }, },
		{ 'k', 'core.integrations.treesitter.previous.heading', opts = { desc = '[neorg] Move to Previous Heading' }, },
	},
	}, {
		silent = true,
		noremap = true,
})

-- Map the below keys only when traverse-link mode is active
keybinds.map_event_to_mode('traverse-link', {
	n = {
		{ 'j', 'core.integrations.treesitter.next.link', opts = { desc = '[neorg] Move to Next Link' } },
		{ 'k', 'core.integrations.treesitter.previous.link', opts = { desc = '[neorg] Move to Previous Link' },
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
		{ leader .. 'mh', '<cmd>Neorg mode traverse-heading<CR>', opts = { desc = '[neorg] Enter Heading Traversal Mode' }, },
		{ leader .. 'ml', '<cmd>Neorg mode traverse-link<CR>', opts = { desc = '[neorg] Enter Link Traversal Mode' }, },
		{ 'gO', '<cmd>Neorg toc split<CR>', opts = { desc = '[neorg] Open a Table of Contents' } },
	},
	}, {
		silent = true,
		noremap = true,
})

-- Map all the below keybinds only when the "norg" mode is active
keybinds.map('norg', 'n', 'sk', '<cmd>Neorg keybind all<cr>', { desc = 'neorg' })
keybinds.map( 'norg', 'n', '<localleader>c', '<cmd>Neorg keybind all core.dirman.new.note<cr><cmd>Neorg inject-metadata<cr>', { desc = '[neorg] create note' })
keybinds.map( 'norg', 'n', '<localleader><localleader>', '<cmd>Neorg update-metadata<cr><cmd>w<cr><cmd>Neorg index<cr>', { desc = '[neorg] save; index' })
keybinds.map('norg', 'n', 'ss', '<cmd>Neorg keybind all core.dirman.new.note<cr>', { desc = 'neorg' })
keybinds.map('norg', 'n', '<localleader>m', 'which_key_ignore', { desc = 'neorg' })
keybinds.map_event_to_mode('norg', {
	n = {
		{ '<C-Space>', 'core.qol.todo_items.todo.task_cycle',         opts = { desc = '[neorg] Cycle Task' } },
		{ leader .. 'c', 'core.dirman.new.note', opts = { desc = '[neorg] create new note' } },
		{ 'ss',        'core.integrations.telescope.find_norg_files', opts = { desc = '[neorg] search neorg files' } },
		{ 'ss', 'core.integrations.telescope.find_norg_files', opts = { desc = '[neorg] search neorg files' } },
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
		{ leader .. 'lt', 'core.pivot.toggle-list-type', opts = { desc = '[neorg] Toggle (Un)ordered List' } },
		{ leader .. 'li', 'core.pivot.invert-list-type', opts = { desc = '[neorg] Invert (Un)ordered List' } },
		{ leader .. 'id', 'core.tempus.insert-date', opts = { desc = '[neorg] Insert Date' } },
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

function M.setup(keybinds)
	keybinds.map('traverse-heading', 'n', 'j', 'core.integrations.treesitter.next.heading', { desc = '[neorg] Move to Next Heading' })
	keybinds.map('traverse-heading', 'n', 'k', 'core.integrations.treesitter.previous.heading', { desc = '[neorg] Move to Previous Heading' })
	keybinds.map('traverse-link', 'n', 'j', 'core.integrations.treesitter.next.link', { desc = '[neorg] Move to Next Link' })
	keybinds.map('traverse-link', 'n', 'k', 'core.integrations.treesitter.previous.link', { desc = '[neorg] Move to Previous Link' })
	keybinds.map('presenter', 'n', '<CR>', 'core.presenter.next_page', { desc = '[neorg] Next Page' })
	keybinds.map('presenter', 'n', 'l', 'core.presenter.next_page', { desc = '[neorg] Next Page' })
	keybinds.map('presenter', 'n', 'h', 'core.presenter.previous_page', { desc = '[neorg] Previous Page' })
	keybinds.map('presenter', 'n', 'q', 'core.presenter.close', { desc = '[neorg] Close Presentation' })
	keybinds.map('presenter', 'n', '<Esc>', 'core.presenter.close', { desc = '[neorg] Close Presentation' })
	keybinds.map('all', 'n', leader .. 'm', '', { desc = '[neorg] Norg Mode' })
	keybinds.map('all', 'n', leader .. 'mn', '<cmd>Neorg mode norg<CR>', { desc = '[neorg] Enter Norg Mode' })
	keybinds.map('all', 'n', leader .. 'mh', '<cmd>Neorg mode traverse-heading<CR>', { desc = '[neorg] Enter Heading Traversal Mode' })
	keybinds.map('all', 'n', leader .. 'ml', '<cmd>Neorg mode traverse-link<CR>', { desc = '[neorg] Enter Link Traversal Mode' })
	keybinds.map('all', 'n', 'gO', '<cmd>Neorg toc split<CR>', { desc = '[neorg] Open a Table of Contents' })
end

return M
