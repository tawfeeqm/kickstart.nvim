-- ~/.config/nvim/lua/plugins.lua
return {
  'marko-cerovac/material.nvim',
  priority = 1000,
  opts = {
    --------------------------------------------------
    -- 1. Disable italics everywhere
    --------------------------------------------------
    styles = {
      comments = { italic = false },
      strings = { italic = false },
      keywords = { italic = false },
      functions = { italic = false },
      variables = { italic = false },
      types = { italic = false },
      operators = { italic = false },
    },

    --------------------------------------------------
    -- 2. Dimmed black background (NOT pure black)
    --------------------------------------------------
    custom_colors = function(colors)
      local BG = '#0B0E14'

      colors.editor.bg       = BG
      colors.editor.contrast = BG
      colors.main.black      = BG

      colors.editor.cursor = '#FFFFFF'
    end,

    --------------------------------------------------
    -- 3. Comprehensive highlight overrides
    --------------------------------------------------
    custom_highlights = {
      --------------------------------------------------
      -- TYPE NAMES (class, interface, struct, enum)
      --------------------------------------------------
      ['@type'] = { fg = '#89B4FA' },
      ['@type.definition'] = { fg = '#89B4FA' },
      ['@type.typescript'] = { fg = '#89B4FA' },
      ['@type.javascript'] = { fg = '#89B4FA' },
      ['@type.cpp'] = { fg = '#89B4FA' },

      -- LSP semantic types (TS)
      ['@lsp.type.class'] = { fg = '#89B4FA' },
      ['@lsp.type.class.typescript'] = { fg = '#89B4FA' },
      ['@lsp.typemod.class.declaration'] = { fg = '#89B4FA' },
      ['@lsp.typemod.class.declaration.typescript'] = { fg = '#89B4FA' },

      --------------------------------------------------
      -- TYPE KEYWORDS (class, struct, interface, enum)
      --------------------------------------------------
      ['@keyword.type'] = { fg = '#C792EA' },
      ['@keyword.type.typescript'] = { fg = '#C792EA' },
      ['@keyword.type.javascript'] = { fg = '#C792EA' },
      ['@keyword.type.cpp'] = { fg = '#C792EA' },

      --------------------------------------------------
      -- ASYNC / AWAIT
      --------------------------------------------------
      ['@keyword.coroutine'] = { fg = '#C792EA' },
      ['@keyword.coroutine.typescript'] = { fg = '#C792EA' },

      --------------------------------------------------
      -- RETURN
      --------------------------------------------------
      ['@keyword.return'] = { fg = '#FF5370' },

      --------------------------------------------------
      -- FUNCTIONS / METHODS
      --------------------------------------------------
      Function = { fg = '#82AAFF' },
      ['@function'] = { fg = '#82AAFF' },
      ['@function.call'] = { fg = '#82AAFF' },
      ['@function.method'] = { fg = '#82AAFF' },
      ['@function.method.call'] = { fg = '#82AAFF' },
      ['@method'] = { fg = '#82AAFF' },
      ['@function.method.cpp'] = { fg = '#82AAFF' },

      --------------------------------------------------
      -- CONSTRUCTORS
      --------------------------------------------------
      ['@constructor'] = { fg = '#C792EA' },

      --------------------------------------------------
      -- PROPERTIES / MEMBERS
      --------------------------------------------------
      ['@property'] = { fg = '#FFFFFF' },
      ['@variable.member'] = { fg = '#FFFFFF' },
      ['@field'] = { fg = '#FFFFFF' },

      --------------------------------------------------
      -- PARAMETERS
      --------------------------------------------------
      ['@variable.parameter'] = { fg = '#FFFFFF' },

      --------------------------------------------------
      -- STRINGS
      --------------------------------------------------
      String = { fg = '#C3E88D' },
      ['@string'] = { fg = '#C3E88D' },

      --------------------------------------------------
      -- NUMBERS
      --------------------------------------------------
      Number = { fg = '#F78C6C' },
      ['@number'] = { fg = '#F78C6C' },

      --------------------------------------------------
      -- C++ SPECIFIC
      --------------------------------------------------
      ['@namespace.cpp'] = { fg = '#89B4FA' },
      ['@macro.cpp'] = { fg = '#C792EA' },
      ['@keyword.directive.cpp'] = { fg = '#C792EA' },
      ['@string.special.include.cpp'] = { fg = '#C3E88D' },

      --------------------------------------------------
      -- DIAGNOSTICS
      --------------------------------------------------
      DiagnosticError = { fg = '#FF5370' },
      DiagnosticWarn  = { fg = '#FFCB6B' },
      DiagnosticInfo  = { fg = '#FFCB6B' },
      DiagnosticHint  = { fg = '#FFCB6B' },

      DiagnosticFloatingError = { fg = '#FF5370' },
      DiagnosticFloatingWarn  = { fg = '#FFCB6B' },
      DiagnosticFloatingInfo  = { fg = '#FFCB6B' },
      DiagnosticFloatingHint  = { fg = '#FFCB6B' },

      DiagnosticVirtualTextError = { fg = '#FF5370' },
      DiagnosticVirtualTextWarn  = { fg = '#FFCB6B' },
      DiagnosticVirtualTextInfo  = { fg = '#FFCB6B' },
      DiagnosticVirtualTextHint  = { fg = '#FFCB6B' },

      DiagnosticUnderlineError = { sp = '#FF5370', undercurl = true },
      DiagnosticUnderlineWarn  = { sp = '#FFCB6B', undercurl = true },
      DiagnosticUnderlineInfo  = { sp = '#FFCB6B', undercurl = true },
      DiagnosticUnderlineHint  = { sp = '#FFCB6B', undercurl = true },
    },
  },

  config = function(_, opts)
    vim.g.material_style = 'deep ocean'
    require('material').setup(opts)
    vim.cmd.colorscheme('material')
  end,
}
