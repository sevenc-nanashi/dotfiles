vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.statuscolumn = '  '
  end,
})
