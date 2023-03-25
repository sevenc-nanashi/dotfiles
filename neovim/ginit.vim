" lua require("cellwidths").setup({ name = "cica"})

let g:font_size = -1

function s:modify_size(size) abort
  exe 'GuiFont!' 'rounded-L M+ 2m Nerd Font:h' .. a:size
  echo 'Font size: ' .. a:size
endfunction

function! s:switch_size() abort
  let g:font_size += 1
  let l:font_sizes = [8, 12]
  if g:font_size >= len(l:font_sizes)
    let g:font_size = 0
  endif
  call s:modify_size(l:font_sizes[g:font_size])
endfunction

nnoremap <silent> <C-K><C-Z> :call <SID>switch_size()<CR>

" vim:ft=vim
