local function setup()
    if IsNotAvailable('telescope') then return end
    require('telescope').setup({
        defaults = {
            -- winblend = 10,
            -- prompt_prefix = '  ',
            -- selection_caret = '➤ ',
            sorting_strategy = 'descending',
            layout_config = {
                horizontal = {
                    preview_cutoff = 180,
                    preview_width = 0.4,
                    prompt_position = 'bottom'
                }
            },
            -- path_display = {
            --     shorten = true,
            --     truncate = true
            -- }
        }
    })

    -- if IsAvailable('telescope-fzf-native') then
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    -- end

    -- https://github.com/jvgrootveld/telescope-zoxide
    require('telescope').load_extension('zoxide')
    vim.api.nvim_set_keymap('n', '<leader>tz', '<cmd>Telescope zoxide list<cr>', {})

    -- find yank_history, depends on yanky
    if IsAvailable('yanky', false) then
        require("telescope").load_extension("yank_history")
        vim.api.nvim_set_keymap('n', '<leader>ty', '<cmd>Telescope yank_history<cr>', {})
    end
    -- require("telescope").load_extension("yank_history")
    -- vim.api.nvim_set_keymap('n', '<leader>ty', '<cmd>Telescope yank_history<cr>', {})

    -- vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', {})
    -- vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', {})
    -- vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', {})

    vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>tw',
        '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>tg', '<cmd>lua require("telescope.builtin").git_status()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>th', '<cmd>lua require("telescope.builtin").help_tags()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>tq', '<cmd>lua require("telescope.builtin").quickfixhistory()<cr>', {})

    -- local use_fzf = false
    local use_fzf = true

    if use_fzf then
        -- use fzf functionality
        vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Buffers<cr>', {})
        vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Files<cr>', {})
        vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>History<cr>', {})

        -- stil map telescope just to try out from time to time
        vim.keymap.set('n', '<leader>tf', function() require("telescope.builtin").find_files() end, {})
        vim.keymap.set('n', '<leader>tu',
            function() require("telescope.builtin").buffers({ sort_mru = true, tiebreak = function() return false end }) end
            , {})
        vim.keymap.set(
            'n', '<leader>to',
            function() require("telescope.builtin").oldfiles({ tiebreak = function() return false end }) end
            , {})
    else
        vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files() end, {})
        vim.keymap.set(
            'n', '<leader>b',
            function() require("telescope.builtin").buffers({ sort_mru = true, tiebreak = function() return false end }) end
            , {})
        vim.keymap.set(
            'n', '<leader>;',
            function() require("telescope.builtin").oldfiles({ tiebreak = function() return false end }) end
            , {})
        vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', {})
    end
    vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>',
        {})

    -- find nvim config files (standard location)
    -- vim.api.nvim_set_keymap('n', '<leader>tv',
    --     '<cmd>lua require("telescope.builtin").find_files({cwd="~/.config/nvim", follow=true})<cr>', {})

    -- find nvim config files, but use actual location (may be override, e.g. by XDG_
    vim.keymap.set('n', '<leader>tc',
        function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') }) end,
        { desc = "Telescope Config: find files in stdpath('config')" })

    vim.keymap.set('n', '<leader>td',
        function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('data') }) end,
        { desc = "Telescope Config: find files in stdpath('data')" })

    -- find spell suggestions of word under cursor
    -- vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>lua require("telescope.builtin").spell_suggest()<cr>', {})

    -- find notes
    vim.api.nvim_set_keymap('n', '<leader>en',
        '<cmd>lua require("telescope.builtin").find_files({cwd="~/notes", follow=true})<cr>', {})

    -- runs `:Telescope`
    vim.api.nvim_set_keymap('n', '<leader>ta', '<cmd>lua require("telescope.builtin").builtin()<cr>', {})

    vim.keymap.set('n', "<leader>tt", function() require("telescope.builtin").resume() end)
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "jvgrootveld/telescope-zoxide",
        "nanotee/zoxide.vim", -- needed to make zoxide plugin work I think, maybe not..??
        { 'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            dependencies = { 'junegunn/fzf.vim', 'junegunn/fzf' },
            config = function()
                require('telescope').load_extension('fzf')
            end
        },
        {
            "nvim-telescope/telescope-dap.nvim",
            config = function()
                if IsAvailable("telescope") then
                    require("telescope").load_extension("dap")
                end
            end,
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            config = function()
                if IsAvailable("telescope") then
                    require("telescope").load_extension("live_grep_args")
                    vim.keymap.set('n', "<leader>tr", function()
                        require("telescope").extensions.live_grep_args.live_grep_args()
                    end)
                end
            end,
        }
    },
    config = function()
        setup()
    end,

}
