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

local parser_config = require "nvim-treesitter.parsers"
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
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('vim-treesitter-start', { clear = true }),
  callback = function()
    local success, _err = pcall(vim.treesitter.start)
    vim.b.treesitter_started = success
  end,
})

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})
vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
vim.g.matchup_treesitter_enable_quotes = true
vim.g.matchup_treesitter_disable_virtual_text = true
vim.g.matchup_treesitter_include_match_words = true

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
require('avante').setup({
  input = {
    provider = "snacks",
  },
  provider = "codex-cli",
  acp_providers = {
    ["gemini-cli"] = {
      command = "gemini",
      args = { "--experimental-acp" },
      env = {
        NODE_NO_WARNINGS = "1",
      },
    },
    ["codex-cli"] = {
      command = "codex-acp",
      env = {
        NODE_NO_WARNINGS = "1",
      },
    },
  }
})
require("render-markdown").setup({
  file_types = { 'avante' },
})
