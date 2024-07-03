local IS_DEV = false

local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	BetterCode =
	"Please provide documentation and provide better variable and function names for the for the following code.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

return {
	{import = "skogix.plugins.extras.skogix.copilot" }, -- Or use { import = "lazyvim.plugins.extras.coding.copilot" },
	-- { import = "lazyvim.plugins.extras.coding.copilot" },
	{
		dir = IS_DEV and "~/Projects/research/CopilotChat.nvim" or nil,
		"CopilotC-Nvim/CopilotChat.nvim",
		version = "v2.10.1",
		-- branch = "canary", -- Use the canary branch if you want to test the latest features but it might be unstable
		-- Do not use branch and version together, either use branch or version
		dependencies = {
			{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			question_header = "## User ",
			answer_header = "## Copilot ",
			error_header = "## Error ",
			prompts = prompts,
			auto_follow_cursor = false, -- Don't follow the cursor after getting response
			show_help = false,       -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
			mappings = {
				-- Use tab for completion
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				-- Close the chat
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				-- Reset the chat buffer
				reset = {
					normal = "<C-x>",
					insert = "<C-x>",
				},
				-- Submit the prompt to Copilot
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-CR>",
				},
				-- Accept the diff
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				-- Yank the diff in the response to register
				yank_diff = {
					normal = "gmy",
				},
				-- Show the diff
				show_diff = {
					normal = "gmd",
				},
				-- Show the prompt
				show_system_prompt = {
					normal = "gmp",
				},
				-- Show the user selection
				show_user_selection = {
					normal = "gms",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			-- Use unnamed register for the selection
			opts.selection = select.unnamed

			-- Override the git prompts message
			opts.prompts.Commit = {
				prompt = "Write commit message for the change with commitizen convention",
				selection = select.gitdiff,
			}
			opts.prompts.CommitStaged = {
				prompt = "Write commit message for the change with commitizen convention",
				selection = function(source)
					return select.gitdiff(source, true)
				end,
			}

			chat.setup(opts)
			-- Setup the CMP integration
			require("CopilotChat.integrations.cmp").setup()

			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })

			-- Custom buffer for CopilotChat
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					-- Get current filetype and set it to markdown if the current filetype is copilot-chat
					local ft = vim.bo.filetype
					if ft == "copilot-chat" then
						vim.bo.filetype = "markdown"
					end
				end,
			})

			-- Add which-key mappings
			local wk = require("which-key")
			wk.register({
				g = {
					m = {
						name = "+Copilot Chat",
						d = "Show diff",
						p = "System prompt",
						s = "Show selection",
						y = "Yank diff",
					},
				},
			})
		end,
		event = "VeryLazy",
		keys = {
			-- Show help actions with telescope
			{
				"<leader>ah",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>aa",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "prompt actions",
			},
			{
				"<leader>aa",
				":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
				mode = "x",
				desc = "prompt actions",
			},
			-- Code related commands
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "explain code" },
			{ "<leader>ab", "<cmd>CopilotChatBetterCode<cr>",        desc = "create better code" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "generate tests" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "review code" },
			{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>",      desc = "refactor code" },
			{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "better naming" },
			-- Chat with Copilot in visual mode
			{
				"<leader>av",
				":CopilotChatVisual",
				mode = "x",
				desc = "open in vertical split",
			},
			{
				"<leader>ax",
				":CopilotChatInline<cr>",
				mode = "x",
				desc = "inline chat",
			},
			-- Custom input for CopilotChat
			{
				"<leader>ai",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "ask input",
			},
			-- Generate commit message based on the git diff
			{
				"<leader>am",
				"<cmd>CopilotChatCommit<cr>",
				desc = "generate commit for all",
			},
			{
				"<leader>aM",
				"<cmd>CopilotChatCommitStaged<cr>",
				desc = "generate commit for staged",
			},
			-- Quick chat with Copilot
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChatBuffer " .. input)
					end
				end,
				desc = "quick chat",
			},
			-- Debug
			{ "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "debug info" },
			-- Fix the issue with diagnostic
			{ "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "fix diagnostic" },
			-- Clear buffer and chat history
			{ "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "clear buffer and chat history" },
			-- Toggle Copilot Chat Vsplit
			{ "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "toggle" },
		},
	},
}
