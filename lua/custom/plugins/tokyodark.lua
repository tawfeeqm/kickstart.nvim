return {
  "tiagovla/tokyodark.nvim",
  -- lazy = false,
  -- priority = 1000,

  opts = {
    transparent_background = true,
    gamma = 1.0,

    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      identifiers = { italic = false },
      functions = {},    -- MUST be a table, no bold support
      variables = {},
    },

    terminal_colors = true,
  },

  config = function(_, opts)
    -- IMPORTANT: setup must be called manually for this plugin
    require("tokyodark").setup(opts)
  end,
}
