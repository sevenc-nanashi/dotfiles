local function mise_command(tool, executable, ...)
  local command = {
    "mise",
    "exec",
    tool,
    "--",
    executable,
  }
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
  vim.keymap.set("i", "<Up>", function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"
  end, { buffer = bufnr, expr = true, silent = true })
  vim.keymap.set("i", "<Down>", function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>"
  end, { buffer = bufnr, expr = true, silent = true })
  vim.keymap.set("i", "<S-Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
  end, { buffer = bufnr, expr = true, silent = true })
  vim.keymap.set("i", "<CR>", function()
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
  end, { buffer = bufnr, expr = true, silent = true })
  map("", "<A-S-F>", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd("Findent")
  end)

end

vim.keymap.set({ "n", "i" }, "<C-D>", function()
  vim.diagnostic.jump({ count = 1 })
end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<C-S-D>", function()
  vim.diagnostic.jump({ count = -1 })
end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-Space>", "<C-X><C-O>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-@>", "<C-X><C-O>", { noremap = true, silent = true })
vim.keymap.set("i", "<M-Space>", "<C-X><C-O>", { noremap = true, silent = true })

local function root_dir(bufnr, on_dir)
  local root = vim.fn["rootfinder#find"](vim.api.nvim_buf_get_name(bufnr))
  if root == "" then
    on_dir()
    return
  end
  vim.api.nvim_set_current_dir(root)
  on_dir(root)
end

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  root_dir = root_dir,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      local completion_group = vim.api.nvim_create_augroup("lsp-completion-" .. args.buf, { clear = true })
      vim.api.nvim_create_autocmd("InsertCharPre", {
        group = completion_group,
        buffer = args.buf,
        callback = function()
          vim.lsp.completion.get()
        end,
      })
    end
  end,
})

local servers = {
  ts_ls = {
    cmd = mise_command("npm:typescript-language-server", "typescript-language-server", "--stdio"),
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  jsonls = {
    cmd = mise_command("npm:vscode-langservers-extracted", "vscode-json-language-server", "--stdio"),
    filetypes = { "json", "jsonc" },
  },
  html = {
    cmd = mise_command("npm:vscode-langservers-extracted", "vscode-html-language-server", "--stdio"),
    filetypes = { "html" },
  },
  eslint = {
    cmd = mise_command("npm:vscode-langservers-extracted", "vscode-eslint-language-server", "--stdio"),
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  prettier = {
    cmd = mise_command("npm:prettier-language-server", "prettier-language-server"),
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "jsonc",
      "css",
      "scss",
      "less",
      "html",
      "markdown",
      "yaml",
      "graphql",
      "vue",
      "svelte",
    },
  },
  yamlls = {
    cmd = mise_command("npm:yaml-language-server", "yaml-language-server", "--stdio"),
    filetypes = { "yaml" },
  },
  rust_analyzer = {
    cmd = mise_command("rust-analyzer", "rust-analyzer"),
    filetypes = { "rust" },
  },
  clangd = {
    cmd = mise_command("github:clangd/clangd", "clangd"),
    filetypes = { "c", "cpp", "objc", "objcpp" },
  },
  pyright = {
    cmd = mise_command("npm:pyright", "pyright-langserver", "--stdio"),
    filetypes = { "python" },
  },
  lua_ls = {
    cmd = mise_command("github:LuaLS/lua-language-server", "lua-language-server"),
    filetypes = { "lua" },
  },
  astro = {
    cmd = mise_command("npm:@astrojs/language-server", "astro-ls", "--stdio"),
    filetypes = { "astro" },
  },
  denols = {
    cmd = mise_command("deno", "deno", "lsp"),
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    auto_start = false,
  },
  cmake = {
    cmd = mise_command("pipx:cmake-language-server", "cmake-language-server"),
    filetypes = { "cmake" },
  },
  protols = {
    cmd = mise_command("github:coder3101/protols", "protols"),
    filetypes = { "proto" },
  },
  texlab = {
    cmd = mise_command("github:latex-lsp/texlab", "texlab"),
    filetypes = { "tex", "plaintex", "bib" },
  },
  ruby_lsp = {
    cmd = mise_command("gem:ruby-lsp", "ruby-lsp"),
    filetypes = { "ruby" },
  },
  version = {
    cmd = mise_command("github:skanehira/version-lsp", "version-lsp"),
    filetypes = { "json", "jsonc", "yaml", "toml" },
  },
  pkl = {
    cmd = mise_command("github:colelawrence/pkl-lsp", "pkl-lsp"),
    filetypes = { "pkl" },
  }
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

local function restart_lsp(name)
  assert(vim.lsp.config[name], "Unknown language server: " .. name)
  vim.lsp.enable(name, false)
  for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
    client:stop(true)
  end
  vim.defer_fn(function()
    vim.lsp.enable(name, true)
  end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function(args)
  if args.args ~= "" then
    restart_lsp(args.args)
    return
  end

  local clients = vim.lsp.get_clients({ bufnr = 0 })
  vim.ui.select(clients, {
    prompt = "Restart language server: ",
    format_item = function(client)
      return string.format("%s (id=%d)", client.name, client.id)
    end,
  }, function(client)
    if client ~= nil then
      restart_lsp(client.name)
    end
  end)
end, {
  nargs = "?",
  complete = function(_, _, _)
    return vim.tbl_keys(servers)
  end,
  force = true,
})

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
