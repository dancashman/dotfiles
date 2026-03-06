local wezterm = require("wezterm")

local platform = require("utils.platform")

local act = wezterm.action

local mod = {}

if platform.is_mac then
	mod.SUPER = "SUPER"
	mod.CTRL = "CTRL"
elseif platform.is_win or platform.is_linux then
	mod.SUPER = "ALT"
	mod.CTRL = "CTRL"
end

local keys = {
	{
		key = "t",
		mods = mod.CTRL,
		action = act.ActivateKeyTable({
			name = "tabs",
			one_shot = true,
			until_unknown = true,
		}),
	},
	{
		key = "p",
		mods = mod.CTRL,
		action = act.ActivateKeyTable({
			name = "activate_pane",
			one_shot = true,
			timeout_milliseconds = 1000,
		}),
	},
	{
		key = "p",
		mods = mod.SUPER,
		action = act.ActivateKeyTable({
			name = "split_panes",
			one_shot = true,
		}),
	},
	{
		key = "r",
		mods = mod.SUPER,
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = true,
		}),
	},
}

local key_tables = {
	tabs = {
		{ key = "h", action = act.ActivateTabRelative(-1) },
		{ key = "l", action = act.ActivateTabRelative(1) },
		{ key = "n", action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "r",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{ key = "Enter", action = "PopKeyTable" },
	},
	activate_pane = {
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "Enter", action = "PopKeyTable" },
	},
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Enter", action = "PopKeyTable" },
	},
	split_panes = {
		{ key = "h", action = act.SplitVertical },
		{ key = "v", action = act.SplitHorizontal },
	},
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Background = { Color = "#2b2042" } },
			{ Text = " " .. title .. " " },
		}
	end

	return title
end)

return {
	keys = keys,
	key_tables = key_tables,
}
