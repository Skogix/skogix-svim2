-- Neovim autocmds
-- This file is automatically loaded by skogix.config.init

-- Function to create an autocmd group with a unique name
-- @param groupName: The name of the autocmd group
-- @return: The unique name of the autocmd group
local function createUniqueAutocmdGroup(groupName)
	return vim.api.nvim_create_augroup('skogix_' .. groupName, {})
end

-- Autocmd for highlighting text on yank
-- This autocmd triggers a highlight on the yanked text
-- The highlight lasts for 50 milliseconds
vim.api.nvim_create_autocmd('TextYankPost', {
	group = createUniqueAutocmdGroup('highlight_yank'),
	callback = function()
		vim.highlight.on_yank({ timeout = 50 })
	end,
})

-- augroup vimrc
--   au BufReadPre * setlocal foldmethod=indent
--   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
-- augroup END

-- Create an autocmd group for foldmethod
local foldmethodGroup = createUniqueAutocmdGroup('foldmethod')

-- Set foldmethod to 'indent' when a buffer is read
vim.api.nvim_create_autocmd('BufReadPre', {
	group = foldmethodGroup,
	callback = function()
		vim.opt_local.foldmethod = 'indent'
	end,
})

-- Change foldmethod to 'manual' when the buffer window is entered
vim.api.nvim_create_autocmd('BufWinEnter', {
	group = foldmethodGroup,
	callback = function()
		if vim.opt_local.foldmethod:get() == 'indent' then
			vim.opt_local.foldmethod = 'marker'
		end
	end,
})
