-- Neovim keymaps
-- This file is automatically loaded by skogix.config.init

local Util = require('skogix.util')
local map = vim.keymap.set

local function open_readme()
  local readme_path = vim.fn.globpath('.', '**/readme.norg', 0, 1)[1]

  if readme_path == nil then
    readme_path = vim.fn.globpath('.', '**/readme.md', 0, 1)[1]
  end

  if readme_path ~= nil then
    vim.cmd("edit " .. readme_path)
  else
    print("Neither readme.norg nor readme.md found in the current directory.")
  end
end
map('n', '<localleader>r', open_readme, { desc = 'Readme' })

map('n', ';', ':', { desc = 'Command' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Copy paste
map({ 'n', 'x' }, '<leader>y', [["+y]]) -- copy to system clipboard
map({ 'n', 'x' }, '<leader>p', [["+p]]) -- paste from system clipboard

-- TODO: keymaps
-- Diagnostic keymaps
-- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
