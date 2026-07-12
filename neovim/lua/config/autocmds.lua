vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function(args)
    vim.bo[args.buf].delimitMate_matchpairs = "(:),[:],{:}"
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("DisableWhitespace")
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.statuscolumn = "  "
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    vim.cmd([[qall!]])
  end,
})

local diagnostic_group = vim.api.nvim_create_augroup("diagnostic-float", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = diagnostic_group,
  callback = function()
    vim.diagnostic.open_float(0, { focus = false, scope = "cursor" })
  end,
})

local findent_group = vim.api.nvim_create_augroup("findent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = findent_group,
  pattern = { "javascript", "json", "typescript" },
  command = "Findent",
})

local fern_group = vim.api.nvim_create_augroup("fern-custom", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = fern_group,
  pattern = "fern",
  callback = function(args)
    vim.keymap.set("n", "<C-K><C-A>", "<Cmd>q<CR>", { buffer = args.buf })
    vim.keymap.set("n", "<CR>", "<Plug>(fern-my-open-or-toggle-expand)", { buffer = args.buf })
    vim.keymap.set("n", "<S-CR>", "<Plug>(fern-action-open-or-enter)", { buffer = args.buf })
    vim.keymap.set("n", "Z", "<Nop>", { buffer = args.buf })
    vim.opt_local.number = false
    vim.keymap.set("n", "<Plug>(fern-my-open-or-toggle-expand)", function()
      local mapping = vim.fn["fern#smart#leaf"](
        "<Plug>(fern-action-open:edit)",
        "<Plug>(fern-action-expand)",
        "<Plug>(fern-action-collapse)"
      )
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(mapping, true, false, true), "m", false)
    end, { buffer = args.buf })
  end,
})

local glyph_group = vim.api.nvim_create_augroup("my-glyph-palette", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = glyph_group,
  pattern = { "fern", "nerdtree", "startify" },
  callback = function()
    vim.fn["glyph_palette#apply"]()
    vim.api.nvim_set_hl(0, "GlyphPalette7", { fg = "#aaaaaa" })
  end,
})
