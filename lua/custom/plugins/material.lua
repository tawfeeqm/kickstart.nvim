-- ~/.config/nvim/lua/plugins.lua

return {
  'marko-cerovac/material.nvim',
  priority = 1000,
  opts = {
    -- 1. Disable Italics globally as requested
    styles = {
      comments = { italic = false },
      strings = { italic = false },
      keywords = { italic = false },
      functions = { italic = false },
      variables = { italic = false },
    },

    -- 2. Custom Colors: Force the Black Background
    custom_colors = function(colors)
      colors.editor.bg = '#000000'
      colors.editor.contrast = '#000000'
      colors.main.black = '#000000'
      -- Ensure the cursor color variable doesn't override our manual setting
      colors.editor.cursor = '#FFFFFF'
    end,

    -- 3. Custom Highlights: The Fixes
    custom_highlights = {
      -- CURSOR: Make it a White block with Black text
      Cursor = { bg = '#FFFFFF', fg = '#000000' },
      TermCursor = { bg = '#FFFFFF', fg = '#000000' },

      -- CLASS KEYWORD: Purple (#C792EA)
      -- The theme source defaults StorageClass to Cyan, so we MUST override it here.
      StorageClass = { fg = '#C792EA' },
      ['@keyword.storage'] = { fg = '#C792EA' },
      ['@storageclass'] = { fg = '#C792EA' },

      -- FUNCTION NAMES: Blue (#82AAFF)
      -- Force all variations of functions/methods to be blue
      Function = { fg = '#82AAFF' },
      ['@function'] = { fg = '#82AAFF' },
      ['@function.call'] = { fg = '#82AAFF' },
      ['@function.method'] = { fg = '#82AAFF' },
      ['@function.method.call'] = { fg = '#82AAFF' },
      ['@method'] = { fg = '#82AAFF' },

      -- CONSTRUCTOR: Purple (#C792EA)
      ['@constructor'] = { fg = '#C792EA' },

      -- RETURN KEYWORD: Red (#FF5370)
      ['@keyword.return'] = { fg = '#FF5370' },

      -- PROPERTIES: White (#FFFFFF)
      -- The text after the dot (e.g. .log, .getElementById)
      ['@property'] = { fg = '#FFFFFF' },
      ['@variable.member'] = { fg = '#FFFFFF' },
      ['@field'] = { fg = '#FFFFFF' },

      -- STRINGS: Green (#C3E88D)
      String = { fg = '#C3E88D' },
      ['@string'] = { fg = '#C3E88D' },

      -- QUOTATION MARKS: Cyan (#89DDFF)
      -- This targets the specific quote characters surrounding the string
      ['@punctuation.quote'] = { fg = '#89DDFF' },
      ['@string.delimiter'] = { fg = '#89DDFF' },
    },
  },
  config = function(_, opts)
    require('material').setup(opts)

    -- Important: Set the style to 'deep ocean' before loading the scheme
    -- to get the correct base palette before our overrides.
    vim.g.material_style = 'deep ocean'
    vim.cmd 'colorscheme material'
  end,
}
