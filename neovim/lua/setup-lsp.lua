local function mise_command(tool, executable, ...)
  local command = { "mise", "x", tool, "--", executable }
  vim.list_extend(command, { ... })
  return command
end

local function on_attach(client, bufnr)
  local options = { buffer = bufnr, silent = true, noremap = true }
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, options)
  end

  map("n", "<Leader>R", vim.lsp.buf.rename)
  map({ "n", "v" }, "<Leader>r", vim.lsp.buf.code_action)
  map({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action)
  map({ "n", "v" }, "<Leader>a", vim.lsp.buf.code_action)
  map("n", "<Leader>u", vim.lsp.buf.references)
  map("n", "<Leader>U", vim.lsp.buf.references)
  map("n", "<Leader>f", vim.lsp.buf.definition)
  map("n", "<Leader>F", vim.lsp.buf.declaration)
  map("n", "<Leader>i", vim.lsp.buf.implementation)
  map("n", "<Leader>t", vim.lsp.buf.type_definition)
  map("n", "<F12>", vim.lsp.buf.definition)
  map("i", "<F12>", vim.lsp.buf.definition)
  map("n", "<F2>", vim.lsp.buf.rename)
  map("i", "<F2>", vim.lsp.buf.rename)
  map({ "n", "i" }, "<M-.>", vim.lsp.buf.hover)
  map("n", "<C-D>", vim.diagnostic.goto_next)
  map("i", "<C-D>", vim.diagnostic.goto_next)
  map("n", "<C-S-D>", vim.diagnostic.goto_prev)
  map("i", "<C-S-D>", vim.diagnostic.goto_prev)
  map("i", "<C-Space>", vim.lsp.completion.get)
  map("i", "<M-Space>", vim.lsp.completion.get)
  map("", "<A-S-F>", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd("Findent")
  end)

  vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
end

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

local servers = {
  ts_ls = {
    cmd = mise_command("npm:typescript-language-server", "typescript-language-server", "--stdio"),
  },
  jsonls = {
    cmd = mise_command("npm:vscode-langservers-extracted", "vscode-json-language-server", "--stdio"),
  },
  html = {
    cmd = mise_command("npm:vscode-langservers-extracted", "vscode-html-language-server", "--stdio"),
  },
  eslint = {
    cmd = mise_command("npm:vscode-langservers-extracted", "vscode-eslint-language-server", "--stdio"),
  },
  yamlls = {
    cmd = mise_command("npm:yaml-language-server", "yaml-language-server", "--stdio"),
  },
  rust_analyzer = {
    cmd = mise_command("cargo:rust-analyzer", "rust-analyzer"),
  },
  clangd = {
    cmd = mise_command("github:clangd/clangd", "clangd"),
  },
  pyright = {
    cmd = mise_command("npm:pyright", "pyright-langserver", "--stdio"),
  },
  lua_ls = {
    cmd = mise_command("github:LuaLS/lua-language-server", "lua-language-server"),
  },
  astro = {
    cmd = mise_command("npm:@astrojs/language-server", "astro-ls", "--stdio"),
  },
  svelte = {
    cmd = mise_command("npm:svelte-language-server", "svelteserver", "--stdio"),
  },
  denols = {
    cmd = mise_command("deno", "deno", "lsp"),
  },
  cmake = {
    cmd = mise_command("pipx:cmake-language-server", "cmake-language-server"),
  },
  protols = {
    cmd = mise_command("github:coder3101/protols", "protols"),
  },
  texlab = {
    cmd = mise_command("cargo:texlab", "texlab"),
  },
  ruby_lsp = {
    cmd = mise_command("gem:ruby-lsp", "ruby-lsp"),
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

vim.keymap.set("n", "K", function()
  if vim.bo.filetype == "vim" or vim.bo.filetype == "help" then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
    return
  end
  if next(vim.lsp.get_clients({ bufnr = 0 })) then
    vim.lsp.buf.hover()
    return
  end
  vim.cmd.normal({ args = "K", bang = false })
end, { noremap = true, silent = true })
