local wezterm = require("wezterm")

local platforms = {
	["x86_64-pc-windows-msvc"] = "windows",
	["aarch64-apple-darwin"] = "mac",
	["x86_64-unknown-linux-gnu"] = "linux",
}

local function contains(str, pattern)
	return string.find(str, pattern) ~= nil
end

--@alias PlatformType 'windows' | 'linux' | 'mac'

--@return {os: PlatformType, is_win: boolean, is_linux: boolean, is_mac: boolean}
local function platform()
	local os = platforms[wezterm.target_triple]

	return {
		os = os,
		is_win = contains(os, "windows"),
		is_linux = contains(os, "linux"),
		is_mac = contains(os, "mac"),
	}
end

local _platform = platform()

return _platform
