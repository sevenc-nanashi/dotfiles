local cmd

if vim.g.terminal then
  cmd = vim.g.terminal
else
  cmd = vim.o.shell
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.glsl", "*.vert", "*.frag", "*.geom", "*.comp" },
  command = "setlocal filetype=glslx",
})
vim.treesitter.language.register("glsl", "glslx")

vim.g.snipewin_label_chars = "ASDFGHJKLQWERTYUIOPZXCVBNM"

vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

require("toggleterm").setup({
  start_in_insert = false,
  on_open = function(term)
    -- vim.cmd("PinBuffer!")
  end,
  auto_scroll = false,
  shell = vim.g.terminal or "nu",
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
require("telescope").setup({
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      file_ignore_patterns = { "package-lock%.json", ".*%.lock", ".*%.min.js" },
      hidden = true,
    },
  },
})
local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal_int,
    augend.constant.alias.bool,
    augend.semver.alias.semver,
    augend.case.new({
      types = { "snake_case", "camelCase", "kebab-case", "PascalCase" },
      cyclic = true,
    }),
  },
})
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
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
parser_config.crystal = {
  install_info = {
    url = "https://github.com/crystal-lang-tools/tree-sitter",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "crystal"
}
parser_config.mcfunction = {
  install_info = {
    url = "https://github.com/IoeCmcomc/tree-sitter-mcfunction.git",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "mcfunction"
}
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  matchup = {
    enable = true,
  }
})
local rainbow_delimiters = require('rainbow-delimiters')
require('rainbow-delimiters.setup').setup {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
  },
  query = {
    [''] = 'rainbow-delimiters',
  },
  highlight = {
    'Rainbow1',
    'Rainbow2',
    'Rainbow3',
    'Rainbow4',
    'Rainbow5',
    'Rainbow6',
  },
}
require("ibl").setup { indent = { highlight = {
  'RainbowDim1',
  'RainbowDim2',
  'RainbowDim3',
  'RainbowDim4',
  'RainbowDim5',
  'RainbowDim6',
},
  char = "|"
} }
require("full_visual_line").setup({})
