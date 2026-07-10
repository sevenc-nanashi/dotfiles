local modules = {
  "setup-mapping",
  "setup-plugins",
  "setup-line",
  "setup-neovide",
  "setup-coc-killer",
  "setup-options",
}

for _, module in ipairs(modules) do
  package.loaded[module] = nil
  require(module)
end
