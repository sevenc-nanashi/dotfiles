
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
" exe 'set runtimepath+=' . $HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim'

"
packadd vim-jetpack
" Required:
call jetpack#begin($HOME . '/.cache/jetpack')

" Let jetpack manage dein
" Required:
" call jetpack#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')
" Add or remove your plugins here like this:
"call jetpack#add('Shougo/neosnippet.vim')
call jetpack#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release', 'build': 'yarn install --frozen-lockfile' })
" call jetpack#add('neoclide/coc.nvim', { 'rev': '5d472ec' })
" call jetpack#add('vim-airline/vim-airline')
call jetpack#add('itchyny/lightline.vim')
call jetpack#add('taohexxx/lightline-buffer')
call jetpack#add('josa42/vim-lightline-coc')
call jetpack#add('ryanoasis/vim-devicons')
" call jetpack#add('sevenc-nanashi/vim-colors-hatsunemiku')
" call jetpack#add('4513echo/vim-colors-hatsunemiku', { 'rev': '359220478a4344db3f2c398b5e8fe6229bd6ca81' })
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
" call jetpack#add('neovim/nvim-lspconfig')
call jetpack#add('github/copilot.vim')
call jetpack#add('mhinz/vim-startify')
" call jetpack#add('andweeb/presence.nvim')
" call jetpack#add('Stoozy/vimcord')
" call jetpack#add('leonardssh/coc-discord-rpc')
" call jetpack#add('hrsh7th/nvim-cmp')
call jetpack#add('sevenc-nanashi/trouble.nvim')
call jetpack#add('kyazdani42/nvim-web-devicons')
" call jetpack#add('Shougo/ddc-nvim-lsp')
" call jetpack#add('Shougo/ddc.vim')
call jetpack#add('vim-denops/denops.vim')
call jetpack#add('windwp/nvim-ts-autotag')
call jetpack#add('lambdalisue/glyph-palette.vim')
" call jetpack#add('jose-elias-alvarez/null-ls.nvim')
" call jetpack#add('nvim-lua/plenary.nvim')
" call jetpack#add('williamboman/mason.nvim')
" call jetpack#add('williamboman/mason-lspconfig.nvim')
" call jetpack#add('MunifTanjim/prettier.nvim')
call jetpack#add('tpope/vim-commentary')
" call jetpack#add('jiangmiao/auto-pairs')
call jetpack#add('Raimondi/delimitMate')
call jetpack#add('LeafCage/vimhelpgenerator')
call jetpack#add('sevenc-nanashi/rootfinder.vim')
call jetpack#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
call jetpack#add('pepo-le/win-ime-con.nvim')
call jetpack#add('airblade/vim-gitgutter')
call jetpack#add('tpope/vim-fugitive')
call jetpack#add('tpope/vim-endwise')
call jetpack#add('alvan/vim-closetag')
call jetpack#add('tyru/open-browser.vim')
call jetpack#add('jason0x43/vim-wildgitignore')
call jetpack#add('Yggdroot/indentLine')
" call jetpack#add('bronson/vim-trailing-whitespace')
call jetpack#add('ldelossa/gh.nvim')
call jetpack#add('ldelossa/litee.nvim')
call jetpack#add('stevearc/stickybuf.nvim')
call jetpack#add('tyru/capture.vim')
call jetpack#add('ntpeters/vim-better-whitespace')
call jetpack#add('tpope/vim-surround')
"call jetpack#add('bronson/vim-trailing-whitespace')
call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('nvim-telescope/telescope.nvim')
call jetpack#add('phaazon/hop.nvim')
call jetpack#add('sevenc-nanashi/force_16term.nvim')
call jetpack#add('kana/vim-submode')
call jetpack#add('fannheyward/telescope-coc.nvim')
call jetpack#add('delphinus/cellwidths.nvim')
"
call jetpack#add('yaegassy/coc-ruby-syntax-tree', { 'do': 'yarn install --frozen-lockfile' })
" Required:
call jetpack#end()

set conceallevel=0
let g:jetpack#auto_recache = 1
let g:jetpack_copy_method = 'hardlink'
let g:indentLine_setConceal = 0

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor
"End dein Scripts-------------------------


set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set backspace=indent,eol,start
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
autocmd BufNew *term://* PinBuffer!

set fileformats=unix,dos
lua package.loaded["nvimrc"] = nil
lua require('nvimrc')

" command! -nargs=+ Search :exe 'vimgrep /<q-args>/j ' .. fnameescape(g:rootfinder#find(expand('%:p:h'))) .. '/**/*'
command! -nargs=1 Search noautocmd vimgrep /<args>/gj `git ls-files` | cw

let g:lightline = {
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ],
      \             [ 'separator' ],
      \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
      \ 'active': {
		  \   'left': [
      \     [ 'mode', 'paste' ],
		  \     [ 'Filename', 'GitSeparator', 'Branch', 'Diff' ],
      \     [ 'coc_status' ],
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'coc_errors', 'coc_warnings', 'coc_info', 'coc_hints', 'coc_none'],
      \     [ 'filetype', 'fileformat', 'fileencoding' ]
      \   ]
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \   'coc_status': 'lightline#coc#status',
      \   'coc_warnings': 'lightline#coc#warnings',
      \   'coc_errors': 'lightline#coc#errors',
      \   'coc_info': 'lightline#coc#info',
      \   'coc_hints': 'lightline#coc#hints',
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \   'coc_status': 'raw',
      \   'coc_warnings': 'warning',
      \   'coc_errors': 'error',
      \   'GitSeparator': 'raw',
      \ },
      \ 'component_function': {
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \   'Branch': 'LlBranch',
      \   'Diff': 'LlDiff',
      \   'line': 'LlLine',
      \   'Filename': 'LlFilename',
      \   'GitSeparator': 'LlGitSeparator',
      \   'coc_status': 'lightline#coc#status',
      \   'coc_none': 'LlCocNone',
      \ },
      \ 'colorscheme': 'edge',
      \ 'separator': { 'left': "\ue0b4", 'right': "\ue0b6" },
      \ 'subseparator': { 'left': "", 'right': "" }
      \ }

let g:lightline#coc#indicator_warnings = "\uf06a "
let g:lightline#coc#indicator_errors = "\uf057 "
let g:lightline#coc#indicator_info = "\uf05a "
let g:lightline#coc#indicator_hints = "\uf059 "
let g:lightline#coc#indicator_ok = '-'
function! LlDiff() abort
  if fugitive#Head() == ''
    return ''
  endif
  let [added, modified, removed] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', added, modified, removed)
endfunction

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

command! LightlineReload call LightlineReload()


function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
set noshowmode

let g:vimhelpgenerator_defaultlanguage = "en"
let g:edge_disable_italic_comment = 1
colorscheme edge

function! s:switch_color() abort
  if g:colo_init == 2
    set background=dark
    let g:colo_init = 1
  else
    set background=light
    let g:colo_init = 2
  endif
  colorscheme edge
  call force_16term#change_color()
  LightlineReload
endfunction
command! -nargs=0 SwitchColor call s:switch_color()

autocmd OptionSet background execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/edge.vim')

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

" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#tabline#enabled = 1

" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ' '
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''

set directory=~/.vim/tmpfiles
set backupdir=~/.vim/tmpfiles
set undodir=~/.vim/tmpfiles


set termguicolors
set nowrap
set clipboard+=unnamedplus
let g:fern#renderer = "nerdfont"
" set wildignore += */node_modules/*
" set wildignore += */.git/*

set mouse=a
set updatetime=300
set showtabline=2
nnoremap U <C-R>
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
nmap gx <Plug>(openbrowser-smart-search)
noremap W b
" let g:findroot_patterns = [
"   \  '.git/',
"   \  '.gitignore',
"   \  'Rakefile',
"   \  'package.json',
"   \  'manifest.json',
"   \  'pyproject.toml',
"   \  'setup.py',
"   \  'requirements.txt',
"   \  'Gemfile',
"   \  'Cargo.toml',
"   \]
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
" noremap <C-K><C-A> <Cmd>Fern . -drawer -width=40<CR>
" noremap <C-K><C-S> <Cmd>ToggleTerm size=20 git_dir=. direction=horizontal<CR>
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
augroup my_config
  autocmd!
  autocmd BufWinEnter *
    \  if &modifiable
    \|   call s:set_normal_mappings()
    \| endif
augroup END
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <silent> <A-S-F> <Cmd>Format<CR>
"  noremap <silent> <A-S-F> <Cmd>lua vim.lsp.buf.format({
"              \     filter = function(client) return client.name ~= "tsserver" end
"              \ })<CR>
" inoremap <silent> <C-Space> <Cmd>lua vim.lsp.buf.completion()<CR>
" noremap <silent> <C-/> <Cmd>lua vim.lsp.buf.signature_help()<CR>

nmap <silent><expr> <F12> CocActionAsync('jumpDefinition')
imap <silent><expr> <F12> CocActionAsync('jumpDefinition')
nmap <silent><expr> <F2> CocActionAsync('rename')
imap <silent><expr> <F2> CocActionAsync('rename')
nmap <silent><expr> <M-.> CocActionAsync('doHover')
imap <silent><expr> <M-.> CocActionAsync('doHover')
noremap <silent> <C-D> <Cmd>call CocAction('diagnosticNext')<CR>
inoremap <silent> <C-D> <Cmd>call CocAction('diagnosticNext')<CR>
nnoremap <silent> <C-S-D> <Cmd>call CocAction('diagnosticPrevious')<CR>
inoremap <silent> <C-S-D> <Cmd>call CocAction('diagnosticPrevious')<CR>
inoremap <silent><expr> <c-space> coc#refresh()
noremap <silent> <c-/> <Cmd>'<,'>Comment<CR>
noremap! <silent> <c-/> <Cmd>'<,'>Comment<CR>
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 RegBuf :enew | put! +
" inoremap <silent><expr> <TAB>
" \ ddc#map#pum_visible() ? '<C-n>' :
" \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
" \ '<TAB>' : ddc#map#manual_complete()

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
  PinBuffer!
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
" let g:presence_editing_text        = "%sを編集中..."
" let g:presence_file_explorer_text  = "%sの中を漁り中..."
" let g:presence_git_commit_text     = "git commit中..."
" let g:presence_plugin_manager_text = "プラグインを管理中..."
" let g:presence_reading_text        = "%sを読書中..."
" let g:presence_workspace_text      = "%sで作業中："
" let g:presence_line_number_text    = "%s / %s行"
" let g:presence_log_level           = "debug"
" call ddc#custom#patch_global('sources', ['around', 'nvim-lsp'])
" call ddc#custom#patch_global('sourceOptions', {
"       \ '_': { 'matchers': ['matcher_head'] },
"       \ 'nvim-lsp': {
"       \   'mark': 'L',
"       \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
"       \ })
" call ddc#enable()
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

if !exists('g:cwd_changed')
  call ReRoot()
  let g:cwd_changed = 0
endif

command! -nargs=0 ReRoot call ReRoot()

let g:copilot_filetypes = {
    \ '*': v:true,
    \ }

if filereadable(expand('~/.nvimrc.local'))
  source ~/.nvimrc.local
endif
