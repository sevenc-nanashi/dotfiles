local debounce_timer = nil
local is_coc_active = true

vim.on_key(function()
  if debounce_timer then
    debounce_timer:stop()
  end
  if not is_coc_active then
    is_coc_active = true
    vim.cmd('call coc#rpc#start_server()')
    vim.notify('Coc started', vim.log.levels.INFO, { title = 'Coc Killer' })
  end
  debounce_timer = vim.defer_fn(function()
    if not is_coc_active then
      return
    end
    is_coc_active = false
    vim.cmd('call coc#rpc#stop()')
    vim.notify('Coc has been disabled', vim.log.levels.INFO, { title = 'Coc Killer' })
  end, 30 * 60 * 1000)
end)
