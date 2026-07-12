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

local function show_lsp_client_output()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    vim.notify("このバッファに接続している言語サーバーはありません", vim.log.levels.INFO)
    return
  end

  vim.ui.select(clients, {
    prompt = "Language server: ",
    format_item = function(client)
      return string.format("%s (id=%d)", client.name, client.id)
    end,
  }, function(client)
    if client == nil then
      return
    end

    local lines = {
      "name: " .. client.name,
      "id: " .. client.id,
      "root_dir: " .. (client.root_dir or ""),
      "server: " .. vim.inspect(client.server_info),
      "command: " .. vim.inspect(client.config.cmd),
      "log: " .. vim.lsp.log.get_filename(),
      "",
      "messages:",
    }
    local messages = client.messages and client.messages.messages or {}
    if #messages == 0 then
      table.insert(lines, "(なし)")
    else
      for _, message in ipairs(messages) do
        vim.list_extend(lines, vim.split(vim.inspect(message), "\n"))
      end
    end

    local buffer_lines = {}
    for _, output_line in ipairs(lines) do
      vim.list_extend(buffer_lines, vim.split(output_line, "\n", { plain = true }))
    end

    vim.cmd("rightbelow vsplit")
    vim.cmd("enew")
    local buffer = vim.api.nvim_get_current_buf()
    vim.bo[buffer].buftype = "nofile"
    vim.bo[buffer].bufhidden = "wipe"
    vim.bo[buffer].swapfile = false
    vim.bo[buffer].filetype = "lspinfo"
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, buffer_lines)
    vim.bo[buffer].modifiable = false
  end)
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
vim.keymap.set("i", "<D-v>", "<C-r><C-p>+", { noremap = false, silent = false })
vim.keymap.set("c", "<D-v>", "<C-r>+", { noremap = false, silent = false })
vim.keymap.set("t", "<D-v>", '<C-\\><C-n>"+pi', { noremap = false, silent = false })
vim.keymap.set("", "<Space>b", "<Cmd>Telescope buffers<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>c", show_lsp_client_output, { noremap = true, silent = true })
vim.keymap.set("", "<Space>f", "<Cmd>Telescope find_files hidden=true<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>G", "<Cmd>Telescope live_grep<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>h", "<Cmd>Telescope help_tags<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gf", "<Cmd>Telescope git_file hidden=trues<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gb", "<Cmd>Telescope git_branches<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gc", "<Cmd>Telescope git_commits<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gC", "<Cmd>Telescope git_bcommits<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<space>gs", "<Cmd>Telescope git_status<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<space>gS", "<Cmd>Telescope git_stash<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>ss", "<Cmd>Telescope lsp_document_symbols<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sS", "<Cmd>Telescope lsp_workspace_symbols<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sD", "<Cmd>Telescope diagnostics<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "<Space>rp", "<Cmd>Rulebook prettifyError<CR>", { noremap = true, silent = true })
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
vim.keymap.set("", "gl", "<Cmd>CopyReference line<CR>", { noremap = false, silent = false })

return {
  switch_color = switch_color,
  show_lsp_client_output = show_lsp_client_output,
}
