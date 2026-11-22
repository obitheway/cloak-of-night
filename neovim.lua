-- Cloak of Night — Neovim spec.
-- Replaces the generated neovim.lua so syntax reads as Jason's four pillars:
--   cloak/dark void background, purple cloak, silver upgraded eyes,
--   blood-red Colin, orange-and-blue Gordon, starlight-cyan Shade.
-- The palette below is the one generated from colors.toml; the autocmd applies
-- the pillar mapping after aether sets its own highlights (its on_highlights
-- callback is declared but unused in v3).

local P = {
  bg = "#0b0614",
  dark_bg = "#070310",
  darker_bg = "#04020a",
  lighter_bg = "#1c1030",
  fg = "#efe2fa",
  dark_fg = "#8f7da8",
  light_fg = "#f5ebfc",
  bright_fg = "#fbf5ff",
  muted = "#6b5a80",

  red = "#e01b3c",
  yellow = "#ffc857",
  orange = "#ff7a45",
  green = "#3fd08a",
  cyan = "#1ce6e9",
  blue = "#4d7cff",
  magenta = "#ff2e97",
  brown = "#6b2d4a",

  bright_red = "#ff4d6a",
  bright_yellow = "#ffd97a",
  bright_green = "#6ee7b0",
  bright_cyan = "#5ff6fa",
  bright_blue = "#7aa2ff",
  bright_magenta = "#ff6ab5",

  accent = "#ff2e97",
  cursor = "#fbf5ff",
  foreground = "#efe2fa",
  background = "#0b0614",
  selection = "#3a1747",
  selection_foreground = "#fbf5ff",
  selection_background = "#3a1747",

  -- The two extra roles this theme adds, not present in colors.toml's Neovim
  -- export: Jason's true violet, and the silver of his upgraded eyes.
  violet = "#b26bff",
  silver = "#d6dde8",
  blood = "#f23956",
  ember = "#FF991C",
}

return {
  {
    "omacom/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "aether",
        callback = function()
          local hl = vim.api.nvim_set_hl

          -- Base surfaces: aether can build these from its defaults depending
          -- on load order, so pin them from our palette explicitly.
          hl(0, "Normal", { fg = P.fg, bg = P.bg })
          hl(0, "NormalNC", { fg = P.fg, bg = P.dark_bg })
          hl(0, "NormalFloat", { fg = P.light_fg, bg = P.darker_bg })
          hl(0, "Comment", { fg = P.muted, italic = true })
          hl(0, "LineNr", { fg = P.dark_fg })
          hl(0, "CursorLine", { bg = P.lighter_bg })
          hl(0, "CursorLineNr", { fg = P.silver, bold = true })
          hl(0, "Visual", { bg = P.selection })
          hl(0, "StatusLine", { fg = P.fg, bg = P.darker_bg })
          hl(0, "StatusLineNC", { fg = P.dark_fg, bg = P.dark_bg })
          hl(0, "Pmenu", { fg = P.fg, bg = P.dark_bg })
          hl(0, "PmenuSel", { fg = P.bright_fg, bg = P.selection })
          hl(0, "Todo", { fg = P.bg, bg = P.yellow, bold = true })
          hl(0, "Conceal", { fg = P.dark_fg })
          hl(0, "NonText", { fg = P.dark_fg })
          hl(0, "VertSplit", { fg = P.muted })
          hl(0, "WinSeparator", { fg = P.muted })

          -- Jason: the violet cloak and the silver starlight in his eyes.
          for _, g in ipairs({
            "Keyword", "Conditional", "Repeat", "Define",
            "@keyword", "@keyword.conditional", "@keyword.repeat",
            "@keyword.function", "@keyword.return",
          }) do
            hl(0, g, { fg = P.violet, bold = true, italic = true })
          end
          for _, g in ipairs({
            "@attribute", "@annotation", "SpecialChar", "@character.special",
            "CursorLineNr", "@markup.link.label",
          }) do
            hl(0, g, { fg = P.silver })
          end

          -- Colin: the sanguine horror, blood red.
          for _, g in ipairs({
            "Function", "@function", "@function.call", "@function.method",
            "@function.method.call", "Tag", "@tag",
          }) do
            hl(0, g, { fg = P.blood, bold = true })
          end

          -- Gordon: the Avatar of Doom — blue nebula and orange butterflies.
          for _, g in ipairs({
            "Number", "Boolean", "Float", "@number", "@boolean", "@float",
          }) do
            hl(0, g, { fg = P.orange })
          end
          for _, g in ipairs({
            "Statement", "Type", "Structure", "Typedef", "StorageClass",
            "@type", "@type.builtin", "@constructor", "@label", "Include",
          }) do
            hl(0, g, { fg = P.bright_blue, bold = true })
          end

          -- Shade: the shadow of the Hegemon, star-cyan rim light.
          for _, g in ipairs({
            "PreProc", "Special", "Identifier", "Macro", "PreCondit",
            "@parameter", "@variable", "@property", "@field", "@preproc",
          }) do
            hl(0, g, { fg = P.cyan })
          end

          -- Gold soul-crest sun for constants. Strings are Gordon's lighter
          -- orange, so they stay distinct from the deeper orange of numbers.
          for _, g in ipairs({ "Constant", "@constant" }) do
            hl(0, g, { fg = P.yellow })
          end
          for _, g in ipairs({
            "String", "@string", "Character", "@character",
            "@string.escape", "@string.special",
          }) do
            hl(0, g, { fg = P.ember })
          end

          -- Keep diagnostics readable rather than pillar-coloured.
          hl(0, "Error", { fg = P.bright_red, bold = true })
          hl(0, "DiagnosticError", { fg = P.bright_red })
          hl(0, "WarningMsg", { fg = P.bright_yellow, bold = true })
        end,
      })
    end,
    opts = {
      colors = {
        bg = P.bg,
        dark_bg = P.dark_bg,
        darker_bg = P.darker_bg,
        lighter_bg = P.lighter_bg,

        fg = P.fg,
        dark_fg = P.dark_fg,
        light_fg = P.light_fg,
        bright_fg = P.bright_fg,
        muted = P.muted,

        red = P.red,
        yellow = P.yellow,
        orange = P.orange,
        green = P.green,
        cyan = P.cyan,
        blue = P.blue,
        magenta = P.magenta,
        brown = P.brown,

        bright_red = P.bright_red,
        bright_yellow = P.bright_yellow,
        bright_green = P.bright_green,
        bright_cyan = P.bright_cyan,
        bright_blue = P.bright_blue,
        bright_magenta = P.bright_magenta,

        accent = P.accent,
        cursor = P.cursor,
        foreground = P.foreground,
        background = P.background,
        selection = P.selection,
        selection_foreground = P.selection_foreground,
        selection_background = P.selection_background,
      },
      on_colors = function(colors)
        -- Give aether's internal purple role the real violet, so groups we
        -- did not name explicitly still read as the cloak rather than pink.
        colors.purple = P.violet
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
