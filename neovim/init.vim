
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
exe 'set runtimepath+=' . $USERPROFILE . $HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim'

" Required:
call dein#begin($USERPROFILE . $HOME . '/.cache/dein')

" Let dein manage dein
" Required:
call dein#add($USERPROFILE . $HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
" call dein#add('neoclide/coc.nvim', { 'rev': '5d472ec' })
call dein#add('vim-airline/vim-airline')
" call dein#add('itchyny/lightline.vim')
call dein#add('ryanoasis/vim-devicons')
" call dein#add('sevenc-nanashi/vim-colors-hatsunemiku')
call dein#add('4513echo/vim-colors-hatsunemiku', { 'rev': '359220478a4344db3f2c398b5e8fe6229bd6ca81' })
call dein#add('akinsho/toggleterm.nvim')
call dein#add('lambdalisue/fern.vim')
call dein#add('lambdalisue/fern-renderer-nerdfont.vim')
call dein#add('lambdalisue/nerdfont.vim')
call dein#add('lambdalisue/fern-hijack.vim')
call dein#add('lambdalisue/fern-git-status.vim')
call dein#add('lambdalisue/fern-mapping-git.vim')
call dein#add('vim-scripts/dbext.vim')
" call dein#add('neovim/nvim-lspconfig')
call dein#add('github/copilot.vim')
call dein#add('mhinz/vim-startify')
" call dein#add('andweeb/presence.nvim')
" call dein#add('Stoozy/vimcord')
" call dein#add('leonardssh/coc-discord-rpc')
" call dein#add('hrsh7th/nvim-cmp')
call dein#add('folke/trouble.nvim')
call dein#add('kyazdani42/nvim-web-devicons')
" call dein#add('Shougo/ddc-nvim-lsp')
" call dein#add('Shougo/ddc.vim')
call dein#add('vim-denops/denops.vim')
call dein#add('windwp/nvim-ts-autotag')
call dein#add('lambdalisue/glyph-palette.vim')
" call dein#add('jose-elias-alvarez/null-ls.nvim')
" call dein#add('nvim-lua/plenary.nvim')
" call dein#add('williamboman/mason.nvim')
" call dein#add('williamboman/mason-lspconfig.nvim')
" call dein#add('MunifTanjim/prettier.nvim')
call dein#add('tpope/vim-commentary')
" call dein#add('jiangmiao/auto-pairs')
call dein#add('Raimondi/delimitMate')
call dein#add('LeafCage/vimhelpgenerator')
call dein#add('sevenc-nanashi/rootfinder.vim')
call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
call dein#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
call dein#add('junegunn/fzf.vim')
call dein#add('pepo-le/win-ime-con.nvim')
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-endwise')
call dein#add('alvan/vim-closetag')
call dein#add('tyru/open-browser.vim')
call dein#add('jason0x43/vim-wildgitignore')
call dein#add('Yggdroot/indentLine')
" call dein#add('bronson/vim-trailing-whitespace')
call dein#add('ldelossa/gh.nvim')
call dein#add('ldelossa/litee.nvim')
call dein#add('stevearc/stickybuf.nvim')
call dein#add('tyru/capture.vim')
call dein#add('ntpeters/vim-better-whitespace')
"call dein#add('bronson/vim-trailing-whitespace')
"
call dein#add('yaegassy/coc-ruby-syntax-tree', { 'do': 'yarn install --frozen-lockfile' })
" Required:
call dein#end()

autocmd Filetype json setl conceallevel=0
let g:dein#auto_recache = 1
let g:indentLine_setConceal = 0

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

if has('win32') || has ('win64')
  set shell=pwsh
  let &shellcmdflag = '-NoLogo -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  set shellquote= shellxquote=
end
" autocmd TermOpen * startinsert
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
autocmd BufNew *term://* PinBuffer

set fileformats=unix,dos
let $PATH .= ';C:/develop/luals/bin'
lua package.loaded["nvimrc"] = nil
lua require('nvimrc')

" command! -nargs=+ Search :exe 'vimgrep /<q-args>/j ' .. fnameescape(g:rootfinder#find(expand('%:p:h'))) .. '/**/*'
command! -nargs=1 Search noautocmd vimgrep /<args>/gj `git ls-files` | cw

if !exists('g:colo_init')
  colo hatsunemiku_light
  let g:airline_theme = 'hatsunemiku_light'
  let g:colo_init = 1
endif

function! s:switch_color() abort
  if g:colo_init == 1
    colo hatsunemiku
    AirlineTheme hatsunemiku
    let g:colo_init = 2
  else
    colo hatsunemiku_light
    AirlineTheme hatsunemiku_light
    let g:colo_init = 1
  endif
endfunction

command! -nargs=0 SwitchColor call s:switch_color()


" let g:lightline = {
"       \ 'colorscheme': 'hatsunemiku_light',
"       \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"       \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
"       \ }
set noshowmode
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1

let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

let g:indentLine_char = '▏ '
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
nnoremap U <C-R>
inoremap <S-Insert> <C-r><C-p>+
cnoremap <S-Insert> <C-r>+
tnoremap <S-Insert> <C-\><C-n>"+pi
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
function! OpenFern()
  let root = g:rootfinder#find(expand('%:p:h'))
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
noremap <C-Tab> <Cmd>bn<CR>
noremap <C-S-W> <Cmd>bd<CR>
noremap <C-S-Tab> <Cmd>bp<CR>
nmap <silent> <C-.> <Plug>(coc-codeaction)

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
nmap <silent> <M-N> <Cmd>call CocAction('diagnosticNext')<CR>
imap <silent> <M-N> <Cmd>call CocAction('diagnosticNext')<CR>
nmap <silent> <M-S-N> <Cmd>call CocAction('diagnosticPrevious')<CR>
imap <silent> <M-S-N> <Cmd>call CocAction('diagnosticPrevious')<CR>
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
  " execute "normal \<Plug>(fern-action-hidden:set)"
endfunction
let g:fern#default_hidden=1
" let g:fern#renderer#nerdfont#leading = ' '
let g:fern#renderer#nerdfont#indent_markers = 1
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
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

