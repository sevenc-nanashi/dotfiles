local sizes = { 7.5, 12 }
local current_size = -1

local function change_size(size, silent)
  vim.o.guifont = "Firple:h" .. size
  vim.o.linespace = 4
  vim.g.neovide_cursor_animation_length = 0
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
