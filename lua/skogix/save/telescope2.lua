-- return {}
-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

-- return {
--   { -- Fuzzy Finder (files, lsp, etc)
--     'nvim-telescope/telescope.nvim',
--     -- event = 'VimEnter',
--     branch = '*',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'nvim-telescope/telescope-project.nvim',
--       'nvim-telescope/telescope-file-browser.nvim',
--       { -- If encountering errors, see telescope-fzf-native README for installation instructions
--         'nvim-telescope/telescope-fzf-native.nvim',
--
--         -- `build` is used to run some command when the plugin is installed/updated.
--         -- This is only run then, not every time Neovim starts up.
--         build = 'make',
--
--         -- `cond` is a condition used to determine whether this plugin should be
--         -- installed and loaded.
--         cond = function()
--           return vim.fn.executable 'make' == 1
--         end,
--       },
--
--       { 'zk-org/zk-nvim' },
--       { 'nvim-telescope/telescope-ui-select.nvim' },
--       { 'ElPiloto/telescope-vimwiki.nvim' },
--       { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
--       { 'nvim-lua/popup.nvim' },
--       { 'debugloop/telescope-undo.nvim' },
--       { 'nvim-telescope/telescope-github.nvim' },
--       { 'xiyaowong/telescope-emoji.nvim' },
--       { 'ahmedkhalf/project.nvim' },
--       { 'ThePrimeagen/harpoon' },
--     },
--     config = function()
--       -- Telescope is a fuzzy finder that comes with a lot of different things that
--       -- it can fuzzy find! It's more than just a "file finder", it can search
--       -- many different aspects of Neovim, your workspace, LSP, and more!
--       --
--       -- The easiest way to use Telescope, is to start by doing something like:
--       --  :Telescope help_tags
--       --
--       -- After running this command, a window will open up and you're able to
--       -- type in the prompt window. You'll see a list of `help_tags` options and
--       -- a corresponding preview of the help.
--       --
--       -- Two important keymaps to use while in Telescope are:
--       --  - Insert mode: <c-/>
--       --  - Normal mode: ?
--       --
--       -- This opens a window that shows you all of the keymaps for the current
--       -- Telescope picker. This is really useful to discover what Telescope can
--       -- do as well as how to actually do it!
--
--       -- [[ Configure Telescope ]]
--       -- See `:help telescope` and `:help telescope.setup()`
--       require('telescope').setup {
--         extensions = {
--           ['ui-select'] = {
--             require('telescope.themes').get_dropdown(),
--           },
--         },
--         require('telescope').setup {
--           defaults = {
--             color_devicons = true,
--             preview = {
--               filesize_hook = function(filepath, bufnr, opts)
--                 local max_bytes = 10000
--                 local cmd = { 'head', '-c', max_bytes, filepath }
--                 require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
--               end,
--             },
--             extensions = {
--               undo = { side_by_side = true, layout_strategy = 'vertical', layout_config = { preview_height = 0.8 } },
--               ['ui-select'] = { require('telescope.themes').get_dropdown {} },
--             },
--             prompt_prefix = '   ',
--             selection_caret = '  ',
--             entry_prefix = '  ',
--             initial_mode = 'insert',
--             selection_strategy = 'reset',
--             sorting_strategy = 'ascending',
--             layout_strategy = 'horizontal',
--             layout_config = {
--               horizontal = { prompt_position = 'top', preview_width = 0.55, results_width = 0.8 },
--               vertical = { mirror = false },
--               width = 0.90,
--               height = 0.90,
--               preview_cutoff = 120,
--             },
--             file_sorter = require('telescope.sorters').get_fuzzy_file,
--             file_ignore_patterns = { 'node_modules' },
--             generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
--             path_display = { 'truncate' },
--             winblend = 0,
--             border = {},
--             borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
--             use_less = true,
--             set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
--             file_previewer = require('telescope.previewers').vim_buffer_cat.new,
--             grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
--             qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
--             -- Developer configurations: Not meant for general override
--             buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
--           },
--         },
--       }
--       -- Enable Telescope extensions if they are installed
--       require('telescope').load_extension 'fzf'
--       require('telescope').load_extension 'ui-select'
--       require('telescope').load_extension 'vimwiki'
--       require('telescope').load_extension 'project'
--       require('telescope').load_extension 'projects'
--       require('telescope').load_extension 'emoji'
--       require('telescope').load_extension 'gh'
--       require('telescope').load_extension 'undo'
--       require('telescope').load_extension 'harpoon'
--       require('telescope').load_extension 'zk'
--     end,
--   },
-- }



return {
  {'nvim-telescope/telescope.nvim'},
  event = 'VimEnter',
  -- branch = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-neorg/neorg-telescope' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make',

      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    config = function()

      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        require('telescope').setup {
          defaults = {
            color_devicons = true,
            preview = {
              filesize_hook = function(filepath, bufnr, opts)
                local max_bytes = 10000
                local cmd = { 'head', '-c', max_bytes, filepath }
                require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
              end,
            },
            extensions = {
              undo = { side_by_side = true, layout_strategy = 'vertical', layout_config = { preview_height = 0.8 } },
              ['ui-select'] = { require('telescope.themes').get_dropdown {} },
            },
            prompt_prefix = '   ',
            selection_caret = '  ',
            entry_prefix = '  ',
            initial_mode = 'insert',
            selection_strategy = 'reset',
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
              horizontal = { prompt_position = 'top', preview_width = 0.55, results_width = 0.8 },
              vertical = { mirror = false },
              width = 0.90,
              height = 0.90,
              preview_cutoff = 120,
            },
            file_sorter = require('telescope.sorters').get_fuzzy_file,
            file_ignore_patterns = { 'node_modules' },
            generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
            path_display = { 'truncate' },
            winblend = 0,
            border = {},
            borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            use_less = true,
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'vimwiki'
      require('telescope').load_extension 'project'
      require('telescope').load_extension 'projects'
      require('telescope').load_extension 'emoji'
      require('telescope').load_extension 'gh'
      require('telescope').load_extension 'undo'
      require('telescope').load_extension 'harpoon'
      require('telescope').load_extension 'zk'
    end
  }}
