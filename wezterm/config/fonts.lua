local wezterm = require("wezterm")
local platform = require("utils.platform")

local font_family = "JetBrains Mono"

local color_scheme = "Ayu Mirage"

local font_size = platform.is_mac and 13 or 9.75

return {
	font = wezterm.font({
		family = font_family,
		weight = "Medium",
	}),
	font_size = font_size,
	color_scheme = color_scheme,
}
