vim.pack.add { "https://github.com/rachartier/tiny-cmdline.nvim" }

require("vim._core.ui2").enable({})

vim.o.cmdheight = 0
require("tiny-cmdline").setup()

vim.api.nvim_set_hl(0, "TinyCmdlineBorder", { fg = "#FFFFFF" })
-- vim.api.nvim_set_hl(0, "TinyCmdlineNormal", { bg = "#your_color" })
