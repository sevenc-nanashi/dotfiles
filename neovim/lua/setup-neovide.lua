local sizes = { 7.5, 12 }
local current_size = -1

local function change_size(size, silent)
  vim.o.guifont = "Firple:h" .. size
  vim.o.linespace = 4
  if not silent then
    vim.cmd("echo 'Font size: " .. size .. "'")
  end
end

local function switch_size(silent)
  current_size = (current_size + 1) % #sizes
  change_size(sizes[current_size + 1], silent)
end

local function init()
  change_size(sizes[1], true)
  vim.keymap.set("n", "<C-K><C-Z>", function() switch_size(false) end, { noremap = true, silent = true })
end

init()

if not vim.g.initialized then
  vim.g.initialized = true
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_vfx_opacity = 75.0
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 50.0
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.o.winblend = 10
  vim.o.pumblend = 10
end
