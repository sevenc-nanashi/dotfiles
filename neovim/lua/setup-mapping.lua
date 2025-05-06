---@diagnostic disable: undefined-global

local line = require("setup-line")
local bit = require('bit')

local function switch_color()
  if vim.g.colo_init == 2 then
    vim.opt.background = "dark"
    vim.g.colo_init = 1
  else
    vim.opt.background = "light"
    vim.g.colo_init = 2
  end
  vim.cmd.colorscheme("edge")
  if vim.g.terminal_color_0 then
    vim.fn["force_16term#change_color"]()
  end
  if vim.o.background == "light" then
    vim.api.nvim_set_hl(0, "Normal", { bg = "#f8feff" })
  end

  local yellow = vim.api.nvim_get_hl(0, { name = "Yellow" }).fg
  local yellow_rgb = {
    bit.rshift(bit.band(yellow, 0xff0000), 16),
    bit.rshift(bit.band(yellow, 0x00ff00), 8),
    bit.band(yellow, 0x0000ff)
  }
  local brighter_yellow;
  if vim.o.background == "light" then
    brighter_yellow = string.format("#%02x%02x%02x", yellow_rgb[1] * 0.75 + 64, yellow_rgb[2] * 0.75 + 64,
      yellow_rgb[3] * 0.75 + 64)
  else
    brighter_yellow = string.format("#%02x%02x%02x", yellow_rgb[1], yellow_rgb[2], yellow_rgb[3])
  end
  vim.api.nvim_set_hl(0, 'QuickScopePrimary', { bold = true, underline = true, fg = brighter_yellow })
  vim.api.nvim_set_hl(0, 'QuickScopeSecondary', { underline = true, fg = brighter_yellow })

  vim.g.terminal_color_15 = "#cccccc"
  line.setup_tint()
end

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  for i, color_name in ipairs({
    'Red',
    'Yellow',
    'Green',
    "Cyan",
    'Blue',
    'Purple'
  }) do
    local current_color = vim.api.nvim_get_hl(0, { name = color_name }).fg
    local red = bit.rshift(bit.band(current_color, 0xff0000), 16)
    local green = bit.rshift(bit.band(current_color, 0x00ff00), 8)
    local blue = bit.band(current_color, 0x0000ff)

    local color, dimmed
    if vim.o.background == "dark" then
      local ratio = 0.9
      local shift = 32
      color = string.format("#%02x%02x%02x", red * ratio + shift, green * ratio + shift, blue * ratio + shift)
      dimmed = string.format("#%02x%02x%02x", red / 4 + 64, green / 4 + 64, blue / 4 + 64)
    else
      local ratio = 3 / 4
      color = string.format("#%02x%02x%02x", red * ratio, green * ratio, blue * ratio)
      dimmed = string.format("#%02x%02x%02x", red / 4 + 192, green / 4 + 192, blue / 4 + 192)
    end
    vim.api.nvim_set_hl(0, 'Rainbow' .. i, { fg = color })
    vim.api.nvim_set_hl(0, 'RainbowDim' .. i, { fg = dimmed })
  end
end)

if not vim.g.colo_init then
  vim.g.edge_enable_italic = 0
  vim.g.edge_disable_italic_comment = 1
  switch_color()
end

vim.api.nvim_set_var("mapleader", ",")
vim.api.nvim_set_var("maplocalleader", "_")

vim.keymap.set("", "U", "<C-R>", { noremap = false, silent = false })
vim.keymap.set("", "<C-S-O>", "<C-I>", { noremap = false, silent = false })
vim.keymap.set("i", "<S-Insert>", "<C-r><C-p>+", { noremap = false, silent = false })
vim.keymap.set("c", "<S-Insert>", "<C-r>+", { noremap = false, silent = false })
vim.keymap.set("t", "<S-Insert>", '<C-\\><C-n>"+pi', { noremap = false, silent = false })
vim.keymap.set("", "<Space>b", "<Cmd>Telescope buffers<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>f", "<Cmd>Telescope find_files hidden=true<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>G", "<Cmd>Telescope live_grep<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>h", "<Cmd>Telescope help_tags<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gf", "<Cmd>Telescope git_file hidden=trues<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gb", "<Cmd>Telescope git_branches<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gc", "<Cmd>Telescope git_commits<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gC", "<Cmd>Telescope git_bcommits<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<space>gs", "<Cmd>Telescope git_status<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<space>gS", "<Cmd>Telescope git_stash<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>ss", "<Cmd>Telescope coc document_symbols<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sS", "<Cmd>Telescope coc workspace_symbols<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sd", "<Cmd>Telescope coc document_diagnostics<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sD", "<Cmd>Telescope coc workspace_diagnostics<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>c", "<Cmd>Telescope coc commands<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>w", "<Cmd>HopWord<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>l", "<Cmd>HopLineStart<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "<Space>W", "<Plug>(snipewin)", { noremap = false, silent = false })
vim.keymap.set("n", "<C-a>", "<Plug>(dial-increment)", { noremap = true, silent = false })
vim.keymap.set("n", "<C-x>", "<Plug>(dial-decrement)", { noremap = true, silent = false })
vim.keymap.set("v", "<C-a>", "<Plug>(dial-increment)", { noremap = true, silent = false })
vim.keymap.set("v", "<C-x>", "<Plug>(dial-decrement)", { noremap = true, silent = false })
vim.keymap.set("v", "g<C-a>", "g<Plug>(dial-increment)", { noremap = true, silent = false })
vim.keymap.set("v", "g<C-x>", "g<Plug>(dial-decrement)", { noremap = true, silent = false })
vim.keymap.set("n", "gx", "<Plug>(openbrowser-smart-search)", { noremap = true, silent = false })
vim.keymap.set("", "W", "b", { noremap = false, silent = false })
vim.keymap.set("", "<Leader>R", "<Plug>(coc-rename)", { noremap = true, silent = false })
vim.keymap.set("", "<Leader>r", "<Plug>(coc-codeaction-refactor-selected)", { noremap = true, silent = false })

vim.keymap.set("", "<C-K><C-A>", function()
  local current_file = vim.fn.expand("%:p:h")
  if current_file:sub(1, 6) == "term://" then
    current_file = current_file:sub(7)
  end
  local root = vim.fn["rootfinder#find"](current_file)
  if #root < 1 then
    root = "."
  end
  vim.cmd("Fern " .. vim.fn.fnameescape(root) .. " -drawer -width=40")
end, { noremap = false, silent = false })
vim.keymap.set(
  "",
  "<C-K><C-S>",
  '<Cmd>exe v:count1 . "ToggleTerm size=20 git_dir=. direction=horizontal"<CR>',
  { noremap = false, silent = false }
)
vim.keymap.set("", "<C-K><C-X>", switch_color, { noremap = false, silent = false })

local is_keycastr_enabled = false
vim.keymap.set("", "<C-K><C-D>", function()
  if is_keycastr_enabled then
    require("keycastr").disable()
    is_keycastr_enabled = false
  else
    require("keycastr").enable()
    is_keycastr_enabled = true
  end
end, { noremap = false, silent = false })
vim.keymap.set("", "<C-Tab>", "<Cmd>bn<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<C-S-W>", "<Cmd>bn<bar>bd#<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<C-S-Tab>", "<Cmd>bp<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "<M-Left>", "<Cmd>bp<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<M-Right>", "<Cmd>bn<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-.>", "<Plug>(coc-codeaction)", { noremap = true, silent = true })
vim.keymap.set("", "<A-S-F>", function()
  vim.fn.CocActionAsync("format", function()
    vim.cmd("Findent")
  end)
end, { noremap = false, silent = true })
vim.keymap.set("n", "<F12>", function()
  vim.fn.CocActionAsync("jumpDefinition")
end, { noremap = true, silent = true })
vim.keymap.set("i", "<F12>", function()
  vim.fn.CocActionAsync("jumpDefinition")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<F2>", function()
  vim.fn.CocActionAsync("rename")
end, { noremap = true, silent = true })
vim.keymap.set("i", "<F2>", function()
  vim.fn.CocActionAsync("rename")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<M-.>", function()
  vim.fn.CocActionAsync("doHover")
end, { noremap = true, silent = true })
-- nnoremap <silent> K :call ShowDocumentation()<CR>
--
-- function! ShowDocumentation()
--   if (index(['vim','help'], &filetype) >= 0)
--     execute 'h '.expand('<cword>')
--   elseif CocAction('hasProvider', 'hover')
--     if coc#float#has_float()
--       call coc#float#jump()
--       nnoremap <buffer> q <Cmd>close<CR>
--     else
--       call CocActionAsync('doHover')
--     endif
--   else
--     call feedkeys('K', 'in')
--   endif
-- endfunction
vim.keymap.set("n", "K", function()
  if vim.bo.filetype == "vim" or vim.bo.filetype == "help" then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.fn.CocAction("hasProvider", "hover") then
    vim.fn.CocActionAsync("doHover")
  else
    vim.fn.feedkeys("K", "in")
  end
end, { noremap = true, silent = true })
vim.keymap.set("n", "J", function()
  if vim.fn["coc#float#has_float"]() == 1 then
    vim.fn["coc#float#jump"]()
  end
end, { noremap = true, silent = true })
vim.keymap.set("i", "<M-.>", function()
  vim.fn.CocActionAsync("doHover")
end, { noremap = true, silent = true })
vim.keymap.set("", "<C-D>", "<Cmd>call CocAction('diagnosticNext')<CR>", { noremap = false, silent = true })
vim.keymap.set("i", "<C-D>", "<Cmd>call CocAction('diagnosticNext')<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-S-D>", "<Cmd>call CocAction('diagnosticPrevious')<CR>", { noremap = false, silent = true })
vim.keymap.set("i", "<C-S-D>", "<Cmd>call CocAction('diagnosticPrevious')<CR>", { noremap = false, silent = true })
vim.keymap.set("i", "<C-Space>", "coc#refresh()", { noremap = true, silent = true, expr = true })
