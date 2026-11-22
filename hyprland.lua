-- Cloak of Night: windows cut out of a star-strewn void cloak.
--
-- A soft violet bloom instead of a hard shadow, and a slow 45deg sweep of the
-- cyan -> sin-pink -> blood-red border whenever focus moves. Omarchy loads
-- this as omarchy.current.theme.hyprland at login and on every theme set.

local active_border_color = { colors = { "rgba(1ce6e9ee)", "rgba(ff2e97ee)", "rgba(e01b3cee)" }, angle = 45 }
local inactive_border_color = "rgba(6b5a80aa)"

hl.config({
  general = {
    border_size = 2,
    gaps_in = 5,
    gaps_out = 12,

    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    rounding = 10,

    shadow = {
      enabled = true,
      range = 20,
      offset = { 0, 6 },
      color = "rgba(0b0614cc)",
      color_inactive = "rgba(0b061488)",
    },
  },

  animations = {
    enabled = true,
  },
})

hl.animation({ leaf = "global", enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "default" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.0, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.6, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3.0, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 12, bezier = "default", style = "once" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "default", style = "fade" })
