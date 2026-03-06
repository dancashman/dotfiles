local wezterm = require("wezterm")

--@class Config
--@field options table
local Config = {}
Config.__index = Config

--Initialize Config
--@return Config
function Config:init()
	local config = setmetatable({}, self)
	return config
end

--Append to 'Config'
--@param new_options table of config options to append
--@return Config 
function Config:append(new_options)
	for k, v in pairs(new_options) do
		if self[k] ~= nil then
			wezterm.log_warn(
				'Duplicate config option detected: ',
				{ old = self[k], new = v }
			)
			goto continue
		end
		self[k] = v
		::continue::
	end
	return self
end

return Config
