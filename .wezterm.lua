local wezterm = require("wezterm")

local config = {}

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

if file_exists(wezterm.config_dir .. "/.wezterm.local.lua") then
  dofile(wezterm.config_dir .. "/.wezterm.local.lua")(config)
end

config.font = wezterm.font("HackGen Console NF")
config.font_size = 10
config.color_scheme = "Edge Dark (base16)"
config.use_ime = true
config.line_height = 1.25
config.initial_rows = 24
config.initial_cols = 128
config.default_prog = config.launch_menu[1].args
config.keys = {
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher },
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
}

return config
