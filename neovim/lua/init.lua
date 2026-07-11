local modules = {
  "setup-lsp",
  "setup-mapping",
  "setup-plugins",
  "setup-line",
  "setup-neovide",
  "setup-options",
}

for _, module in ipairs(modules) do
  package.loaded[module] = nil
  require(module)
end
