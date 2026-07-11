require("config.pack")
require("config.options")

require("setup-lsp")
local mapping = require("setup-mapping")
require("setup-plugins")
require("setup-line")
require("setup-neovide")
require("config.autocmds")

vim.api.nvim_create_user_command("SwitchColor", mapping.switch_color, { force = true })
