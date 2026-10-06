vim.pack.add {
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/marko-cerovac/material.nvim',
}

require('kanagawa').setup {
  commentStyle = {},
  functionStyle = {},
  keywordStyle = {},
  statementStyle = {},
  typeStyle = {},
}

require('material').setup {
  async_loading = false,
  custom_highlights = function(colors)
    return {
      ['@keyword.return'] = { fg = colors.main.red },
      Cursor = { fg = colors.editor.bg, bg = colors.main.white },
      lCursor = { fg = colors.editor.bg, bg = colors.main.white },
    }
  end,
  styles = {
    comments = {},
    strings = {},
    keywords = {},
    functions = {},
    variables = {},
    operators = {},
    types = {},
  },
}

-- Remove styles from highlight groups not covered by each theme's setup API.
local function remove_font_styles()
  for name, highlight in pairs(vim.api.nvim_get_hl(0, {})) do
    if not highlight.link and (highlight.bold or highlight.italic) then
      highlight.bold = false
      highlight.italic = false
      highlight.default = nil
      if highlight.cterm then
        highlight.cterm.bold = false
        highlight.cterm.italic = false
      end
      vim.api.nvim_set_hl(0, name, highlight)
    end
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('plain-theme-text', { clear = true }),
  pattern = { 'kanagawa*', 'material*' },
  callback = function()
    remove_font_styles()
    -- Some themes define captures immediately after ColorScheme finishes.
    vim.schedule(remove_font_styles)
  end,
})

vim.cmd.colorscheme 'material-darker'
