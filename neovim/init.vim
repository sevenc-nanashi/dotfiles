if &compatible
  set nocompatible
endif
lua vim.loader.enable()
packadd vim-jetpack
call jetpack#begin($HOME . '/.cache/jetpack')
call jetpack#add('tani/vim-jetpack')
call jetpack#add('neoclide/coc.nvim', { 'merged': 0, 'branch': 'release', 'build': 'yarn install --frozen-lockfile' })
call jetpack#add('nvim-lualine/lualine.nvim')
call jetpack#add('nvim-tree/nvim-web-devicons')
call jetpack#add('ryanoasis/vim-devicons')
call jetpack#add('sainnhe/edge')
call jetpack#add('akinsho/toggleterm.nvim')
call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/fern-hijack.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('lambdalisue/fern-mapping-git.vim')
call jetpack#add('github/copilot.vim')
call jetpack#add('mhinz/vim-startify')
call jetpack#add('0xAdk/full_visual_line.nvim')
call jetpack#add('vim-denops/denops.vim')
call jetpack#add('windwp/nvim-ts-autotag')
call jetpack#add('lambdalisue/glyph-palette.vim')
call jetpack#add('tyru/caw.vim')
call jetpack#add('Shougo/context_filetype.vim')
call jetpack#add('Raimondi/delimitMate')
call jetpack#add('sevenc-nanashi/rootfinder.vim')
call jetpack#add('gpanders/editorconfig.nvim')
call jetpack#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
call jetpack#add('nvim-treesitter/playground')
call jetpack#add('pepo-le/win-ime-con.nvim')
call jetpack#add('lewis6991/gitsigns.nvim')
call jetpack#add('tpope/vim-fugitive')
call jetpack#add('tpope/vim-endwise')
call jetpack#add('alvan/vim-closetag')
call jetpack#add('tyru/open-browser.vim')
call jetpack#add('ldelossa/litee.nvim')
call jetpack#add('tyru/capture.vim')
call jetpack#add('ntpeters/vim-better-whitespace')
call jetpack#add('machakann/vim-sandwich')
call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('nvim-telescope/telescope.nvim')
call jetpack#add('phaazon/hop.nvim')
call jetpack#add('sevenc-nanashi/force_16term.nvim')
call jetpack#add('kana/vim-submode')
call jetpack#add('fannheyward/telescope-coc.nvim')
call jetpack#add('monaqa/dial.nvim')
call jetpack#add('rcarriga/nvim-notify')
call jetpack#add('MunifTanjim/nui.nvim')
call jetpack#add('sevenc-nanashi/tint.nvim', { 'branch': 'patch-1'})
" call jetpack#add('unblevable/quick-scope')
call jetpack#add('4513ECHO/vim-snipewin')
call jetpack#add('lambdalisue/vim-findent')
call jetpack#add('HiPhish/rainbow-delimiters.nvim')
call jetpack#add('lukas-reineke/indent-blankline.nvim')
call jetpack#add('andymass/vim-matchup')
call jetpack#add('folke/noice.nvim')
call jetpack#add('mattn/invader-vim')
call jetpack#add('4513ECHO/nvim-keycastr')
call jetpack#add('lervag/vimtex')
call jetpack#add('neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' })
call jetpack#add('yaegassy/coc-typeprof', {'do': 'yarn install --frozen-lockfile'})
call jetpack#add('yaegassy/coc-ruby-syntax-tree', {'do': 'yarn install --frozen-lockfile'})
call jetpack#add('kanium3/neovide-ime.nvim')
call jetpack#add('tpope/vim-rhubarb')
call jetpack#add('S-H-GAMELINKS/coc-typeprof', {'do': 'npm ci'})

call jetpack#end()

set termguicolors
set conceallevel=0
set showtabline=0
let g:jetpack#auto_recache = 1
let g:jetpack_copy_method = 'hardlink'
let g:indentLine_setConceal = 0
let g:snipewin_label_font = 'asciian_inverted'
runtime macros/sandwich/keymap/surround.vim

filetype plugin indent on
syntax enable

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

let g:copilot_filetypes = {
    \ '*': v:true,
    \ }

if filereadable(expand('~/.nvimrc.local'))
  source ~/.nvimrc.local
endif

set encoding=utf-8
set fileencoding=utf-8
"set termencoding=utf-8
set backspace=indent,eol,start
set laststatus=3
set number
set expandtab

autocmd FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"
autocmd TermOpen * DisableWhitespace
" autocmd BufNew *term://* PinBuffer!

set fileformats=unix,dos
" lua package.loaded["nvimrc"] = nil
" lua require('nvimrc')

" command! -nargs=+ Search :exe 'vimgrep /<q-args>/j ' .. fnameescape(g:rootfinder#find(expand('%:p:h'))) .. '/**/*'

function! ReloadLua()
  let l:init_lua = stdpath('config') . '/lua/init.lua'
  if filereadable(l:init_lua)
    lua package.loaded["init"] = nil
    lua require('init')
  else
    echoerr 'init.lua not found: ' . l:init_lua
  endif
endfunction
command! -nargs=0 ReloadLua call ReloadLua()

if !exists('g:reload_rc_initialized')
  function! ReloadRc()
    source $MYVIMRC
    call ReloadLua()
  endfunction
  command! -nargs=0 ReloadRc call ReloadRc()
  let g:reload_rc_initialized = 1
endif

call ReloadLua()

set noshowmode

let g:vimhelpgenerator_defaultlanguage = "en"
let g:edge_disable_italic_comment = 1

function! s:switch_color() abort
  if g:colo_init == 2
    set background=dark
    let g:colo_init = 1
  else
    set background=light
    let g:colo_init = 2
  endif
  colorscheme edge
  if exists('g:terminal_color_0')
    call force_16term#change_color()
  endif
  " LightlineReload
endfunction
command! -nargs=0 SwitchColor call s:switch_color()

if !exists('g:colo_init')
  let g:colo_init = 0
  call s:switch_color()
endif

set directory=~/.vim/tmpfiles
set backupdir=~/.vim/tmpfiles
set undodir=~/.vim/tmpfiles


set nowrap
set clipboard+=unnamedplus
let g:fern#renderer = "nerdfont"

set mouse=a
set updatetime=300

for i in range(1, 9)
  exe 'nnoremap <silent><M-' . i % 10 . '> :exe "b " . <SID>get_buffer_id(' . i . ')<CR>'
endfor

command! -nargs=0 -bang Bdelete :bn<bar>bd<bang>#

function! s:get_buffer_id(index) abort
  let counter = 0
  for i in range(1, bufnr('$'))
    if !buflisted(i)
      continue
    endif
    if getbufvar(i, '&readonly') || !getbufvar(i, '&modifiable')
      continue
    endif
    let counter += 1
    if counter == a:index
      return i
    endif
  endfor
  return ""
endfunction


function! s:set_normal_mappings() abort
  nnoremap <buffer> <CR> a<CR><ESC>
endfunction
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

command! -nargs=0 RegBuf :enew | put! +

function! s:init_fern() abort
  noremap <buffer> <C-K><C-A> <Cmd>q<CR>
  nmap <buffer><expr> <Plug>(fern-my-open-or-toggle-expand)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:edit)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> <CR> <Plug>(fern-my-open-or-toggle-expand)
  " nmap <buffer> <LeftMouse> <Plug>(fern-my-open-or-toggle-expand)
  nmap <buffer> <S-CR> <Plug>(fern-action-open-or-enter)
  nmap <buffer> <Z> <Nop>
  setl nonumber
  " PinBuffer!
  " execute "normal \<Plug>(fern-action-hidden:set)"
endfunction

let g:fern#default_hidden=1
" let g:fern#renderer#nerdfont#leading = ' '
let g:fern#renderer#nerdfont#indent_markers = 1
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply() | hi GlyphPalette7 guifg=#aaaaaa
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

augroup on-qt-exit
  autocmd! *
  autocmd UILeave * qall!
augroup END

set signcolumn=yes
match Ignore /\r$/
let $FZF_DEFAULT_OPTS='--no-unicode'

function! ReRoot() abort
  let s:root = rootfinder#find(getcwd())
  if len(s:root) > 0
    execute 'cd' fnameescape(s:root)
    echo 'Root: ' s:root
  else
    echo 'Root not found'
  endif
endfunction

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

function! Scouter(file, ...)
let pat = '^\s*$\|^\s*"'
let lines = readfile(a:file)
if !a:0 || !a:1
  let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
endif
return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)
augroup findent
  autocmd!
  autocmd FileType javascript Findent
  autocmd FileType json Findent
  autocmd FileType typescript Findent
augroup END

let g:tcomment#filetype#guess = { -> context_filetype#get().filetype }
