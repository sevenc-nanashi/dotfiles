require("toggleterm").setup({
	start_in_insert = false,
	on_open = function(term)
		vim.cmd("PinBuffer!")
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
	-- グループ名を指定しない場合に用いられる被加数
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number
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

--[=[
require("mason").setup()
require("mason-lspconfig").setup()

-- nvim-lspconfig
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.syntax_tree.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
--]=]
-- Treesitter config
-- local status, ts = pcall(require, "nvim-treesitter.configs")
-- if (not status) then return end

-- ts.setup {
--   highlight = {
--     enable = true,
--     disable = {},
--   },
--   indent = {
--     enable = true,
--     disable = {},
--   },
--   autotag = {
--     enable = true,
--   },
-- }

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

--[=[
-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

local prettier = require("prettier")

prettier.setup({
    bin = "C:/Users/.../AppData/Roaming/npm/prettier.cmd"
})
]=]
