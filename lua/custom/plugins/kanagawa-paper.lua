return {
  'thesimonho/kanagawa-paper.nvim',
  opts = {
    overrides = function(colors)
      -- local red = '#E46876' -- Kanagawa red
      local red = '#C46A70'
      return {
        --------------------------------------------------
        -- VARIABLES (ALL LANGUAGES)
        --------------------------------------------------
        ['@variable.member'] = { fg = red },
        -- ['@variable.parameter'] = { fg = red },

        --------------------------------------------------
        -- RETURN KEYWORD (ALL LANGUAGES)
        --------------------------------------------------
        ['@keyword.return'] = { fg = red },
      }
    end,
  },
  config = function(_, opts)
    require('kanagawa-paper').setup(opts)
  end,
}
