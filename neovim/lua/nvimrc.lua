require("toggleterm").setup{
  start_in_insert = false,
  on_open = function(term)
    vim.cmd("PinBuffer!")
  end,
}
require("trouble").setup {}
require 'nvim-treesitter.install'.compilers = { "clang" }
require('nvim-ts-autotag').setup()
require('litee.lib').setup()
require('litee.gh').setup()
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

