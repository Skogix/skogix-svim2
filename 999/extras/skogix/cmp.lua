local compare = require('cmp.config.compare')
local types = require('cmp.types')
local misc = require('cmp.utils.misc')
local keymap = require('cmp.utils.keymap')

local mapping = setmetatable({}, {
	__call = function(_, invoke, modes)
		if type(invoke) == 'function' then
			local map = {}
			for _, mode in ipairs(modes or { 'i' }) do
				map[mode] = invoke
			end
			return map
		end
		return invoke
	end,
})

---Invoke completion
---@param option? cmp.CompleteParams
mapping.complete = function(option)
	return function(fallback)
		if not require('cmp').complete(option) then
			fallback()
		end
	end
end

---Complete common string.
mapping.complete_common_string = function()
	return function(fallback)
		if not require('cmp').complete_common_string() then
			fallback()
		end
	end
end

---Close current completion menu if it displayed.
mapping.close = function()
	return function(fallback)
		if not require('cmp').close() then
			fallback()
		end
	end
end

---Abort current completion menu if it displayed.
mapping.abort = function()
	return function(fallback)
		if not require('cmp').abort() then
			fallback()
		end
	end
end

---Scroll documentation window.
mapping.scroll_docs = function(delta)
	return function(fallback)
		if not require('cmp').scroll_docs(delta) then
			fallback()
		end
	end
end

--- Opens the documentation window.
mapping.open_docs = function()
	return function(fallback)
		if not require('cmp').open_docs() then
			fallback()
		end
	end
end

--- Close the documentation window.
mapping.close_docs = function()
	return function(fallback)
		if not require('cmp').close_docs() then
			fallback()
		end
	end
end

---Select next completion item.
mapping.select_next_item = function(option)
	return function(fallback)
		if not require('cmp').select_next_item(option) then
			local release = require('cmp').core:suspend()
			fallback()
			vim.schedule(release)
		end
	end
end

---Select prev completion item.
mapping.select_prev_item = function(option)
	return function(fallback)
		if not require('cmp').select_prev_item(option) then
			local release = require('cmp').core:suspend()
			fallback()
			vim.schedule(release)
		end
	end
end

---Confirm selection
mapping.confirm = function(option)
	return function(fallback)
		if not require('cmp').confirm(option) then
			fallback()
		end
	end
end

local function merge_keymaps(base, override)
	local normalized_base = {}
	for k, v in pairs(base) do
		normalized_base[keymap.normalize(k)] = v
	end

	local normalized_override = {}
	for k, v in pairs(override) do
		normalized_override[keymap.normalize(k)] = v
	end

	return misc.merge(normalized_base, normalized_override)
end


local WIDE_HEIGHT = 40

---@type cmp.ConfigSchema
return {
	enabled = true,
	performance = {
		debounce = 60,
		throttle = 30,
		fetching_timeout = 500,
		confirm_resolve_timeout = 80,
		async_budget = 1,
		max_view_entries = 200,
	},

	mapping = {
		{
			['<Down>'] = {
				i = mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
			},
			['<Up>'] = {
				i = mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
			},
			['<C-n>'] = {
				i = function()
					local cmp = require('cmp')
					if cmp.visible() then
						cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
					else
						cmp.complete()
					end
				end,
			},
			['<C-p>'] = {
				i = function()
					local cmp = require('cmp')
					if cmp.visible() then
						cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
					else
						cmp.complete()
					end
				end,
			},
			['<C-y>'] = {
				i = mapping.confirm({ select = false }),
			},
			['<C-e>'] = {
				i = mapping.abort(),
			},
		},
		['<C-z>'] = {
			c = function()
				local cmp = require('cmp')
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
		},
		['<Tab>'] = {
			c = function()
				local cmp = require('cmp')
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
		},
		['<S-Tab>'] = {
			c = function()
				local cmp = require('cmp')
				if cmp.visible() then
					cmp.select_prev_item()
				else
					cmp.complete()
				end
			end,
		},
		['<C-n>'] = {
			c = function(fallback)
				local cmp = require('cmp')
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		['<C-p>'] = {
			c = function(fallback)
				local cmp = require('cmp')
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
		['<C-e>'] = {
			c = mapping.abort(),
		},
		['<C-y>'] = {
			c = mapping.confirm({ select = false }),
		},
	},
	snippet = {
		expand = vim.fn.has('nvim-0.10') == 1 and function(args)
			vim.snippet.expand(args.body)
		end or function(_)
		error('snippet engine is not configured.')
	end,
},

completion = {
	autocomplete = {
		types.cmp.TriggerEvent.TextChanged,
	},
	completeopt = 'menu,menuone,noselect',
	keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
	keyword_length = 1,
},

formatting = {
	expandable_indicator = true,
	fields = { 'abbr', 'kind', 'menu' },
	format = function(_, vim_item)
		return vim_item
	end,
},

matching = {
	disallow_fuzzy_matching = false,
	disallow_fullfuzzy_matching = false,
	disallow_partial_fuzzy_matching = true,
	disallow_partial_matching = false,
	disallow_prefix_unmatching = false,
	disallow_symbol_nonprefix_matching = true,
},

sorting = {
	priority_weight = 2,
	comparators = {
		compare.offset,
		compare.exact,
		-- compare.scopes,
		compare.score,
		compare.recently_used,
		compare.locality,
		compare.kind,
		-- compare.sort_text,
		compare.length,
		compare.order,
	},
},

sources = {
	{ name = "buffer" },
},

confirmation = {
	default_behavior = types.cmp.ConfirmBehavior.Insert,
	get_commit_characters = function(commit_characters)
		return commit_characters
	end,
},

event = {},

experimental = {
	ghost_text = false,
},

view = {
	entries = {
		name = 'custom',
		selection_order = 'top_down',
		follow_cursor = false,
	},
	docs = {
		auto_open = true,
	},
},

window = {
	completion = {
		border = { '', '', '', '', '', '', '', '' },
		winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
		winblend = vim.o.pumblend,
		scrolloff = 0,
		col_offset = 0,
		side_padding = 1,
		scrollbar = true,
	},
	documentation = {
		max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
		max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
		border = { '', '', '', ' ', '', '', '', ' ' },
		winhighlight = 'FloatBorder:NormalFloat',
		winblend = vim.o.pumblend,
	},
},
{
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
},
{
	"nvim-cmp",
	dependencies = {
		{
			"garymjr/nvim-snippets",
			opts = {
				friendly_snippets = true,
			},
			dependencies = { "rafamadriz/friendly-snippets" },
		},
	},
	opts = function(_, opts)
		opts.snippet = {
			expand = function(item)
				return LazyVim.cmp.expand(item.body)
			end,
		}
		if LazyVim.has("nvim-snippets") then
			table.insert(opts.sources, { name = "snippets" })
		end
	end,
	keys = {
		{
			"<Tab>",
			function()
				return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
			end,
			expr = true,
			silent = true,
			mode = { "i", "s" },
		},
		{
			"<S-Tab>",
			function()
				return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
			end,
			expr = true,
			silent = true,
			mode = { "i", "s" },
		},
	},
},
{
	"garymjr/nvim-snippets",
	opts = {
		friendly_snippets = true,
	},
	dependencies = { "rafamadriz/friendly-snippets" },
},
{ "rafamadriz/friendly-snippets" },
{
	"echasnovski/mini.pairs",
	event = "VeryLazy",
	opts = {
		modes = { insert = true, command = true, terminal = false },
		-- skip autopair when next character is one of these
		skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
		-- skip autopair when the cursor is inside these treesitter nodes
		skip_ts = { "string" },
		-- skip autopair when next character is closing pair
		-- and there are more closing pairs than opening pairs
		skip_unbalanced = true,
		-- better deal with markdown code blocks
		markdown = true,
	},
	keys = {
		{
			"<leader>up",
			function()
				vim.g.minipairs_disable = not vim.g.minipairs_disable
				if vim.g.minipairs_disable then
					LazyVim.warn("Disabled auto pairs", { title = "Option" })
				else
					LazyVim.info("Enabled auto pairs", { title = "Option" })
				end
			end,
			desc = "Toggle Auto Pairs",
		},
	},
	config = function(_, opts)
		LazyVim.mini.pairs(opts)
	end,
},
{
	"folke/ts-comments.nvim",
	event = "VeryLazy",
	opts = {},
},
{
	"echasnovski/mini.ai",
	event = "VeryLazy",
	opts = function()
		LazyVim.on_load("which-key.nvim", function()
			vim.schedule(LazyVim.mini.ai_whichkey)
		end)
		local ai = require("mini.ai")
		return {
			n_lines = 500,
			custom_textobjects = {
				o = ai.gen_spec.treesitter({ -- code block
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
				d = { "%f[%d]%d+" }, -- digits
				e = { -- Word with case
					{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
					"^().*()$",
				},
				i = LazyVim.mini.ai_indent, -- indent
				g = LazyVim.mini.ai_buffer, -- buffer
				u = ai.gen_spec.function_call(), -- u for "Usage"
				U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
			},
		}
	end,
},
{
	"folke/lazydev.nvim",
	ft = "lua",
	cmd = "LazyDev",
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			{ path = "LazyVim", words = { "LazyVim" } },
			{ path = "lazy.nvim", words = { "LazyVim" } },
		},
	},
},
{ "Bilal2453/luvit-meta", lazy = true },
{
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
		table.insert(opts.sources, { name = "lazydev", group_index = 0 })
	end,
},
{
	"hrsh7th/nvim-cmp",
	dependencies = { "hrsh7th/cmp-emoji" },
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
		table.insert(opts.sources, { name = "emoji", group_index = 1 })
	end,
},
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"zbirenbaum/copilot-cmp",
	},
	opts = function(_, opts)
		table.insert(opts.sources, { name = "copilot", group_index = 1})
	end,
},
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"lukas-reineke/cmp-rg",
	},
	opts = function(_, opts)
		table.insert(opts.sources, { name = "rg", keyword_length = 3, group_index = 0 })
	end,
},
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"David-Kunz/cmp-npm",
	},
	opts = function(_, opts)
		table.insert(opts.sources, { name = "npm", keyword_length = 4, group_index = 1})
	end,
},
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = function(_, opts)
		table.insert(opts.sources, { name = "nvim_lsp", keyword_length = 3, group_index = 0 })
	end,
},
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"chrisgrieser/cmp_yanky",
	},
	opts = function(_, opts)
		table.insert(opts.sources, { name = "cmp_yanky", group_index = 2 })
	end,
},
-- Git source for nvim-cmp
{
	"hrsh7th/nvim-cmp",
	dependencies = {
			'petertriho/cmp-git',
			opts = {},
			config = function()
				local cmp = require('cmp')
				cmp.setup.filetype('gitcommit', {
					sources = cmp.config.sources({
						{ name = 'git', priority = 50 },
						{ name = 'path', priority = 40 },
					}, {
						{ name = 'buffer', priority = 50 },
					}),
				})
			end,
		},
}
}
