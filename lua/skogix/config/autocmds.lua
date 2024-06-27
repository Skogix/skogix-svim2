-- Neovim autocmds
-- This file is automatically loaded by skogix.config.init

local function augroup(name)
	return vim.api.nvim_create_augroup('skogix_' .. name, {})
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = augroup('highlight_yank'),
	callback = function()
		vim.highlight.on_yank({ timeout = 50 })
	end,
})
