return {
  'thesimonho/kanagawa-paper.nvim',
  opts = {
    overrides = function(colors)
      local red = '#C46A70'
      return {
        --------------------------------------------------
        -- PARAMETERS (Arguments in functions)
        --------------------------------------------------
        ['@variable.parameter'] = { fg = red },
        ['@lsp.type.parameter'] = { fg = red }, -- Force LSP parameter color

        --------------------------------------------------
        -- MEMBERS / PROPERTIES (obj.member)
        --------------------------------------------------
        ['@variable.member'] = { fg = red },
        ['@property']        = { fg = red }, -- Fallback for some languages
        ['@lsp.type.property'] = { fg = red }, -- Force LSP property color
        ['@lsp.type.enumMember'] = { fg = red },

        --------------------------------------------------
        -- RETURN KEYWORD
        --------------------------------------------------
        ['@keyword.return'] = { fg = red },
      }
    end,
  },
  config = function(_, opts)
    require('kanagawa-paper').setup(opts)
  end,
}
