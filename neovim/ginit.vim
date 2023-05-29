" lua require("cellwidths").setup({ name = "cica"})

let g:font_size = -1

function s:modify_size(size, silent) abort
  exe 'GuiFont!' 'FirgeNerd:h' .. a:size
  exe 'GuiLinespace' '4'
  if !a:silent
    echo 'Font size: ' .. a:size
  endif
endfunction

function! s:switch_size(silent) abort
  let g:font_size += 1
  let l:font_sizes = [8, 12]
  if g:font_size >= len(l:font_sizes)
    let g:font_size = 0
  endif
  call s:modify_size(l:font_sizes[g:font_size], a:silent)
endfunction

nnoremap <silent> <C-K><C-Z> :call <SID>switch_size(0)<CR>
call s:switch_size(1)

" vim:ft=vim
