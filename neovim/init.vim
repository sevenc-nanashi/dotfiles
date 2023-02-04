if &compatible
  set nocompatible
endif
packadd vim-jetpack
call jetpack#begin($HOME . '/.cache/jetpack')
call jetpack#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release', 'build': 'yarn install --frozen-lockfile' })
call jetpack#add('nvim-lualine/lualine.nvim')
call jetpack#add('akinsho/bufferline.nvim')
call jetpack#add('nvim-tree/nvim-web-devicons')
call jetpack#add('ryanoasis/vim-devicons')
call jetpack#add('sainnhe/edge')
call jetpack#add('chriskempson/base16-vim')
call jetpack#add('sevenc-nanashi/toggleterm.nvim')
call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/fern-hijack.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('lambdalisue/fern-mapping-git.vim')
call jetpack#add('vim-scripts/dbext.vim')
call jetpack#add('github/copilot.vim')
call jetpack#add('mhinz/vim-startify')
call jetpack#add('sevenc-nanashi/trouble.nvim')
call jetpack#add('kyazdani42/nvim-web-devicons')
call jetpack#add('vim-denops/denops.vim')
call jetpack#add('windwp/nvim-ts-autotag')
call jetpack#add('lambdalisue/glyph-palette.vim')
call jetpack#add('tpope/vim-commentary')
call jetpack#add('Raimondi/delimitMate')
call jetpack#add('LeafCage/vimhelpgenerator')
call jetpack#add('sevenc-nanashi/rootfinder.vim')
call jetpack#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
call jetpack#add('pepo-le/win-ime-con.nvim')
call jetpack#add('lewis6991/gitsigns.nvim')
call jetpack#add('tpope/vim-fugitive')
call jetpack#add('tpope/vim-endwise')
call jetpack#add('alvan/vim-closetag')
call jetpack#add('tyru/open-browser.vim')
call jetpack#add('jason0x43/vim-wildgitignore')
call jetpack#add('Yggdroot/indentLine')
call jetpack#add('ldelossa/gh.nvim')
call jetpack#add('ldelossa/litee.nvim')
call jetpack#add('tyru/capture.vim')
call jetpack#add('ntpeters/vim-better-whitespace')
call jetpack#add('tpope/vim-surround')
call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('nvim-telescope/telescope.nvim')
call jetpack#add('phaazon/hop.nvim')
call jetpack#add('sevenc-nanashi/force_16term.nvim')
call jetpack#add('kana/vim-submode')
call jetpack#add('fannheyward/telescope-coc.nvim')
call jetpack#add('monaqa/dial.nvim')
call jetpack#add('lambdalisue/mr.vim')
call jetpack#add('delphinus/cellwidths.nvim')
call jetpack#add('nvim-telescope/telescope-frecency.nvim')
call jetpack#add('kkharji/sqlite.lua')
call jetpack#add('Shougo/vimproc.vim', {'build' : 'make'})
call jetpack#add('folke/noice.nvim')
call jetpack#add('rcarriga/nvim-notify')
call jetpack#add('MunifTanjim/nui.nvim')
call jetpack#add('Allianaab2m/vimskey')
call jetpack#add('levouh/tint.nvim')

call jetpack#add('yaegassy/coc-ruby-syntax-tree', { 'do': 'yarn install --frozen-lockfile' })

call jetpack#end()

set conceallevel=0
let g:jetpack#auto_recache = 1
let g:jetpack_copy_method = 'hardlink'
let g:indentLine_setConceal = 0

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
set termencoding=utf-8
set backspace=indent,eol,start
set laststatus=3
set number
set expandtab

set tabstop=2
set shiftwidth=2
function! s:set_tab_width(width)
  exe 'setlocal tabstop=' . a:width
  exe 'setlocal shiftwidth=' . a:width
endfunction

function! s:disable_lines_if_readonly() abort
  if &modifiable == 0
    IndentLinesDisable
  endif
endfunction

autocmd FileType python call s:set_tab_width(4)
autocmd FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"
autocmd FileType * call s:disable_lines_if_readonly()
autocmd TermOpen * IndentLinesDisable
autocmd TermOpen * DisableWhitespace
" autocmd BufNew *term://* PinBuffer!

set fileformats=unix,dos
" lua package.loaded["nvimrc"] = nil
" lua require('nvimrc')

" command! -nargs=+ Search :exe 'vimgrep /<q-args>/j ' .. fnameescape(g:rootfinder#find(expand('%:p:h'))) .. '/**/*'
command! -nargs=1 Search noautocmd vimgrep /<args>/gj `git ls-files` | cw


function! LlLine() abort
  return "\ue621"
endfunction

function! LlGitSeparator() abort
  if fugitive#Head() == ''
    return ''
  endif
  return "\ue0b5"
endfunction

function! LlBranch() abort
  if fugitive#Head() == ''
    return ""
  endif
  return "\ue725 " .. fugitive#Head()
endfunction

function! LlFilename() abort
  let l:fname = expand('%:t')
  if l:fname == ''
    let l:fname = '-'
  endif
  if &modified
    let l:fname = l:fname . ' +'
  endif
  if &readonly
    let l:fname = "\uf720 " .. l:fname
  else
    let l:fname = "\uf713 " .. l:fname
  endif
  return l:fname
endfunction


function! LlRootName() abort
  let l:root = rootfinder#find(expand('%:p:h'))
  if l:root == ''
    return "\ue5fe -"
  endif
  return "\ue5fe " . fnamemodify(l:root, ':t')
endfunction
function! LlCocNone() abort
  let l:diagnostics = get(b:, 'coc_diagnostic_info', {})
  if l:diagnostics == {} ||
        \  (l:diagnostics.error == 0 &&
        \   l:diagnostics.warning == 0 &&
        \   l:diagnostics.information == 0 &&
        \   l:diagnostics.hint == 0)
    return '-'
  endif
  return ''
endfunction

" function! ReloadLightline()
"   call lightline#init()
"   call lightline#colorscheme()
"   call lightline#update()
" endfunction
" command! -nargs=0 ReloadLightline call ReloadLightline()

function! ReloadLua()
  let l:init_lua = stdpath('config') . '/lua/init.lua'
  if filereadable(l:init_lua)
    lua require('init')
    lua package.loaded["init"] = nil
  else
    echoerr 'init.lua not found: ' . l:init_lua
  endif
endfunction
command! -nargs=0 ReloadLua call ReloadLua()

function! ReloadRc()
  source $MYVIMRC
  call ReloadLua()
endfunction
command! -nargs=0 ReloadRc call ReloadRc()

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

let g:lightline_buffer_enable_devicons = 1
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']
let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20
let g:lightline_buffer_separator_left_icon = "\ue0b5 "
let g:lightline_buffer_separator_right_icon = '  '
let g:lightline_buffer_active_buffer_left_icon = ' '
let g:lightline_buffer_active_buffer_right_icon = ' '

set directory=~/.vim/tmpfiles
set backupdir=~/.vim/tmpfiles
set undodir=~/.vim/tmpfiles


set termguicolors
set nowrap
set clipboard+=unnamedplus
let g:fern#renderer = "nerdfont"

set mouse=a
set updatetime=300
set showtabline=2
noremap U <C-R>
noremap <C-S-O> <C-I>
inoremap <S-Insert> <C-r><C-p>+
cnoremap <S-Insert> <C-r>+
tnoremap <S-Insert> <C-\><C-n>"+pi

noremap <Space>b <Cmd>Telescope buffers<CR>
noremap <Space>f <Cmd>Telescope find_files<CR>
noremap <Space>G <Cmd>Telescope live_grep<CR>
noremap <Space>h <Cmd>Telescope help_tags<CR>
noremap <Space>gf <Cmd>Telescope git_files<CR>
noremap <Space>gb <Cmd>Telescope git_branches<CR>
noremap <Space>gs <Cmd>Telescope git_status<CR>
noremap <Space>ss <Cmd>Telescope coc document_symbols<CR>
noremap <Space>sS <Cmd>Telescope coc workspace_symbols<CR>
noremap <Space>sd <Cmd>Telescope coc document_diagnostics<CR>
noremap <Space>sD <Cmd>Telescope coc workspace_diagnostics<CR>
noremap <Space>c <Cmd>Telescope coc commands<CR>
noremap <Space>w <Cmd>HopWord<CR>
noremap <Space>l <Cmd>HopLineStart<CR>
nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)
nmap gx <Plug>(openbrowser-smart-search)
noremap W b
function! OpenFern() abort
  let current_file = expand('%:p:h')
  if current_file[:6] == "term://"
    let current_file = current_file[7:]
  endif
  let root = g:rootfinder#find(current_file)
  if len(root) < 1
    let root = '.'
  endif
  execute 'Fern ' .. fnameescape(root) .. ' -drawer -width=40'
endfunction

noremap <C-K><C-A> <Cmd>call OpenFern()<CR>
noremap <C-K><C-S> <Cmd>exe v:count1 . "ToggleTerm size=20 git_dir=. direction=horizontal"<CR>
noremap <C-K><C-D> <Cmd>TroubleToggle<CR>
noremap <C-K><C-X> <Cmd>call <SID>switch_color()<CR>

noremap <C-Tab> <Cmd>bn<CR>
noremap <C-S-W> <Cmd>bn<bar>bd#<CR>
noremap <C-S-Tab> <Cmd>bp<CR>

nnoremap <silent> <M-Left> <Cmd>bp<CR>
nnoremap <silent> <M-Right> <Cmd>bn<CR>
nmap <silent> <C-.> <Plug>(coc-codeaction)
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
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
