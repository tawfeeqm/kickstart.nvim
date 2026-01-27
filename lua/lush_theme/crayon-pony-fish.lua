-- lua/lush_theme/crayon-pony-fish.lua
local lush = require 'lush'
local hsl = lush.hsl

-- 1. DEFINE PALETTE
local bg_dark = hsl '#150707' -- The dark brown background
local fg_muted = hsl '#68525a'
local fg_bright = hsl '#b0949d'

local black = hsl '#2b1b1d'
local bright_black = hsl '#3d2b2e'

-- Rosy Red (kept from before)
local red = hsl('#91002b').desaturate(40).lighten(20)
local bright_red = hsl('#c5255d').desaturate(20)

-- Pop Green (kept from before)
local green = hsl('#2B3B2B').lighten(30).saturate(10)
local bright_green = hsl '#083308'

local yellow = hsl '#E3A510'
local dim_yellow = hsl '#85623A'

local blue = hsl '#8c87b0'
local bright_blue = hsl '#cfc9ff'
local magenta = hsl '#692f50'
local beige = hsl '#e8a866'
local bright_beige = hsl '#ffceaf'
local orange = hsl '#AD3A0E'
local white = hsl '#ffffff'

-- --- NEW COLORS ---

-- 1. Pastel Purple (Properties/Members) - Kept this because you liked it
local pastel_purple = hsl '#e0cfff'

-- 2. Dusty Rose (Keywords) - REPLACES THE DARK PURPLE
-- We take the background (#150707), lighten it significantly (60%),
-- and add a tiny bit of saturation (10%) so it isn't gray.
-- This creates a "lighter shade of the background" look.
-- local dusty_rose    = bg_dark.lighten(60).saturate(10)
local dusty_rose = hsl '#693254'

-- ------------------

-- 2. DEFINE THEME
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- Base Groups
    Normal { bg = bg_dark, fg = fg_bright },
    CursorLine { bg = bright_black },
    Visual { bg = magenta.darken(40) },
    Search { bg = dusty_rose, fg = bg_dark },
    IncSearch { bg = pastel_purple, fg = bg_dark },
    LineNr { fg = fg_muted.darken(20) },
    CursorLineNr { fg = bright_beige, gui = 'bold' },
    StatusLine { bg = black, fg = fg_muted },
    VertSplit { fg = black },
    WinSeparator { fg = black },

    -- UI Elements
    Pmenu { bg = black, fg = fg_bright },
    PmenuSel { bg = dusty_rose.darken(30), fg = fg_bright },
    MatchParen { fg = green, gui = 'bold' },

    -- Syntax
    Comment { fg = fg_muted, gui = 'italic' },
    String { fg = green },

    -- Numbers/Booleans stay Pastel Purple
    Number { fg = orange },
    Boolean { fg = pastel_purple },

    -- KEYWORDS are now Dusty Rose (Lighter Background Shade)
    Keyword { fg = dusty_rose },
    Conditional { fg = dusty_rose },
    Repeat { fg = dusty_rose },
    Include { fg = dusty_rose },
    StorageClass { fg = dusty_rose },
    Structure { fg = fg_muted },

    Function { fg = dusty_rose },
    Identifier { fg = fg_muted },
    Type { fg = fg_muted },

    -- Diagnostics
    DiagnosticError { fg = red },
    DiagnosticWarn { fg = magenta },
    DiagnosticInfo { fg = blue },
    DiagnosticHint { fg = fg_muted },

    -- TreeSitter Links
    sym '@comment' { Comment },
    sym '@string' { String },
    sym '@function' { Function },

    -- Keyword mapping
    sym '@keyword' { Keyword },
    sym '@keyword.coroutine' { Keyword },
    sym '@keyword.function' { fg = beige },
    sym '@keyword.operator' { Keyword },

    -- Properties -> Pastel Purple
    sym '@property' { fg = fg_muted },
    sym '@variable.member' { fg = fg_muted },
    sym '@variable.parameter' { fg = beige },
    sym '@field' { fg = fg_muted },

    sym '@variable' { fg = fg_muted },
    sym '@type' { Type },
    sym '@tag' { fg = fg_muted },
  }
end)

return theme
