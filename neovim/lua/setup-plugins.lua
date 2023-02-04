require("toggleterm").setup({
	start_in_insert = false,
	on_open = function(term)
		-- vim.cmd("PinBuffer!")
	end,
	cmd = "pwsh -NoLogo",
})
require("trouble").setup({
	mode = "coc_workspace_diagnostics",
})
require("nvim-treesitter.install").compilers = { "clang" }
require("nvim-ts-autotag").setup()
require("litee.lib").setup()
require("litee.gh").setup()
require("hop").setup()
require("telescope").load_extension("frecency")
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
	name = "user/default",
	fallback = function(cw)
		cw.load("default")

		cw.add(0x2192, 2)
		cw.add(0x2190, 2)
		cw.add(0x2713, 2)
		cw.add(0x276f, 1)
		cw.add(0x279c, 1)
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
require("noice").setup({})
require("tint").setup({
  tint = 80,
})
