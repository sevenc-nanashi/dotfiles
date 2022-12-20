" lua require("cellwidths").setup({ name = "cica"})

let g:font_size = 9

function s:modify_size(size) abort
  let g:font_size = a:size
  exe 'GuiFont!' 'Rounded-L M+ 2m Nerd Font:h' .. g:font_size
  echo 'Font size: ' .. g:font_size
endfunction

function! s:switch_size() abort
  if g:font_size == 9
    call s:modify_size(12)
  else

    call s:modify_size(9)
  endif
endfunction

nnoremap <silent> <C-K><C-Z> :call <SID>switch_size()<CR>

" vim:ft=vim
