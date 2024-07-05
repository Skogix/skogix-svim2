return {
    'andymass/vim-matchup',
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_delim_stopline = 100
    end
}
