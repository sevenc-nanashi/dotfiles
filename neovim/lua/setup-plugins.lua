local cmd

if vim.g.terminal then
  cmd = vim.g.terminal
else
  cmd = vim.o.shell
end
vim.g.snipewin_label_chars = "ASDFGHJKLQWERTYUIOPZXCVBNM"
require("toggleterm").setup({
  start_in_insert = false,
  on_open = function(term)
    -- vim.cmd("PinBuffer!")
  end,
  cmd = cmd,
})
require("trouble").setup({
  mode = "coc_workspace_diagnostics",
})
require("nvim-ts-autotag").setup()
require("litee.lib").setup()
require("hop").setup()
-- require("highlight-undo").setup({
-- 	mappings = {
-- 		undo = "u",
-- 		redo = "U",
-- 	},
-- })
local ignore_patterns = { "%.git", "node_modules", "%.venv", "__pycache__", "dist", "build", "target", "out" }
require("telescope").setup({
  pickers = {
    find_files = {
      file_ignore_patterns = ignore_patterns,
      hidden = true,
    },
    live_grep = {
      file_ignore_patterns = { "package-lock%.json", ".*%.lock", ".*%.min.js", unpack(ignore_patterns) },
      hidden = true,
    },
  },
})
require("cellwidths").setup({
  name = "user/my",
  fallback = function(cw)
    cw.load("default")

    cw.add(0x2192, 2)
    cw.add(0x2190, 2)
    cw.add(0x2713, 2)
    cw.add(0x276f, 1)
    cw.add(0x279c, 1)
    cw.add(8250, 1)
    cw.add(9650, 1)
    cw.add(10003, 1)
    cw.add(10004, 1)
    cw.add(10007, 1)
    cw.add(10008, 1)
  end,
})
local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.constant.new({
      elements = { "true", "false" },
      word = true,
      cyclic = true,
    }),
    augend.case.new({
      types = { "snake_case", "camelCase", "kebab-case", "PascalCase" },
      cyclic = true,
    }),
  },
})
require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
})
require("noice").setup({
  messages = {
    view = "mini",
    view_error = "mini",
    view_warn = "mini",
  },
  presets = {
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true,
    lsp_doc_border = false,
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.sus = {
  install_info = {
    url = "https://github.com/sevenc-nanashi/tree-sitter-sus.git",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "sus"
}
parser_config.rbs = {
  install_info = {
    url = "https://github.com/apexatoll/tree-sitter-rbs.git",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "rbs"
}
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
require("catppuccin").setup({
  flavour = "latte",
  no_italic = true,
})
require("full_visual_line").setup({})
