return {
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- nvim-cmp source for neovim builtin LSP client
			'hrsh7th/cmp-nvim-lsp',
			-- nvim-cmp source for buffer words
			'hrsh7th/cmp-buffer',
			-- nvim-cmp source for path
			'hrsh7th/cmp-path',
			-- nvim-cmp source for emoji
			'hrsh7th/cmp-emoji',
		},
		-- Not all LSP servers add brackets when completing a function.
		-- To better deal with this, LazyVim adds a custom option to cmp,
		-- that you can configure. For example:
		--
		-- ```lua
		-- opts = {
		--   auto_brackets = { 'python' }
		-- }
		-- ```

		opts = function()
			vim.api.nvim_set_hl(
				0,
				'CmpGhostText',
				{ link = 'Comment', default = true }
			)
			local cmp = require('cmp')
			local defaults = require('cmp.config.default')()
			local Util = require('skogix.util')

			return {
				-- configure any filetype to auto add brackets
				auto_brackets = { 'python' },
				view = {
					entries = { follow_cursor = true },
				},
				sorting = defaults.sorting,
				experimental = {
					ghost_text = {
						hl_group = 'Comment',
					},
				},
				sources = cmp.config.sources({
					{ name = 'neorg', priority = 40 },
					{ name = 'nvim_lsp', priority = 50 },
					{ name = 'path', priority = 40 },

    				{ name = 'nvim_lua', priority = 60  },
				}, {
					{ name = 'buffer', priority = 50, keyword_length = 3 },
					{ name = 'emoji', insert = true, priority = 20 },
				}),
				mapping = cmp.mapping.preset.insert({
					-- <CR> accepts currently selected item.
					['<CR>'] = LazyVim.cmp.confirm(),
					-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<S-CR>'] = LazyVim.cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					['<C-Space>'] = cmp.mapping.complete(),
					['<Tab>'] = Util.cmp.supertab({
						behavior = require('cmp').SelectBehavior.Select,
					}),
					['<S-Tab>'] = Util.cmp.supertab_shift({
						behavior = require('cmp').SelectBehavior.Select,
					}),
					['<C-j>'] = Util.cmp.snippet_jump_forward(),
					['<C-k>'] = Util.cmp.snippet_jump_backward(),
					['<C-n>'] = cmp.mapping.select_next_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					['<C-p>'] = cmp.mapping.select_prev_item({
						behavior = cmp.SelectBehavior.Insert,
					}),
					['<C-d>'] = cmp.mapping.select_next_item({ count = 5 }),
					['<C-u>'] = cmp.mapping.select_prev_item({ count = 5 }),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-c>'] = function(fallback)
						cmp.close()
						fallback()
					end,
					['<C-e>'] = cmp.mapping(function()
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end),
				}),
				formatting = {
					format = function(entry, item)
						-- Prepend with a fancy icon from config.
						local icons = require('lazyvim.config').icons
						if entry.source.name == 'git' then
							item.kind = icons.misc.git
						else
							local icon = icons.kinds[item.kind]
							if icon ~= nil then
								item.kind = icon .. ' ' .. item.kind
							end
						end
						return item
					end,
				},
			}
		end,
		---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
		config = function(_, opts)
			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end

			local parse = require('cmp.utils.snippet').parse
			---@diagnostic disable-next-line: duplicate-set-field
			require('cmp.utils.snippet').parse = function(input)
				local ok, ret = pcall(parse, input)
				if ok then
					return ret
				end
				return LazyVim.cmp.snippet_preview(input)
			end

			local cmp = require('cmp')
			cmp.setup(opts)
			cmp.event:on('confirm_done', function(event)
				if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
					LazyVim.cmp.auto_brackets(event.entry)
				end
			end)
			cmp.event:on('menu_opened', function(event)
				LazyVim.cmp.add_missing_snippet_docs(event.window)
			end)
		end,
	},
}
