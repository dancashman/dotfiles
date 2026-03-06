local Config = require("config")

return Config:init():append(require("config.fonts")):append(require("config.keys"))
