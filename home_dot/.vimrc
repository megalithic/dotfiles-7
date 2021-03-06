if !1 | finish | endif

" basic settings{{{1
set nocompatible
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
language message C
language time C
set langmenu=none
let g:mapleader = ','
set t_Co=256
set cindent
set vb t_vb=
set nobackup
set backupskip=/tmp/*,/private/tmp/*
set swapfile
if !isdirectory($HOME . '/.vim_swap')
  call mkdir($HOME . '/.vim_swap', 'p')
endif
set directory=~/.vim_swap
if has('persistent_undo')
  if !isdirectory($HOME . '/.vim_undo')
    call mkdir($HOME . '/.vim_undo', 'p')
  endif
  set undodir=~/.vim_undo
  set undofile
endif
set ruler
set laststatus=2
set notitle
set noequalalways
set iskeyword+=\-
set backspace=indent,eol,start
set history=100
set autoread
set wildmenu
set incsearch
set hlsearch
set ignorecase
set smartcase
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set shiftround
set foldmethod=marker
set foldlevel=0
set formatoptions+=r
set cinoptions=(0,g0,t0
set keywordprg=:help
set splitright
set splitbelow
set completeopt-=preview
"set virtualedit+=block
set nrformats=hex,alpha
set lazyredraw
set ttyfast
set updatetime=300
set timeoutlen=500
set ttimeout
set ttimeoutlen=50
set display=lastline
set statusline=%f%m%=\ %{shina#face()}%-14.(%l,%v%)\ %P
" set pumheight=5
set spelllang+=cjk
set matchpairs+=（:）,「:」,『:』,＜:＞,【:】
set hidden
set clipboard=unnamed
set mouse=
set noshowcmd
set conceallevel=0
set concealcursor=
set list
set listchars=tab:>\･
"set synmaxcol=200
set guicursor=
"set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
"autocmd VimLeave * set guicursor=a:block-blinkon1
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
syntax enable
autocmd ColorScheme * highlight Normal cterm=none ctermfg=231 ctermbg=none gui=none guifg=#fffeeb guibg=#020814
autocmd ColorScheme * highlight Ignore cterm=none ctermfg=231 gui=none guifg=#fffeeb
autocmd ColorScheme * highlight EndOfBuffer cterm=none ctermfg=242 gui=none guifg=#fffeeb
autocmd ColorScheme * highlight TabLineFill cterm=reverse ctermfg=242 gui=reverse guifg=#3a4b5c
autocmd ColorScheme * highlight ZenkakuSpace cterm=none ctermbg=9 gui=none guibg=#ff0000
autocmd ColorScheme * highlight TabString cterm=none ctermfg=239 ctermbg=none gui=none guibg=#303030
autocmd ColorScheme * highlight TrailingSpaces term=underline ctermbg=238 guibg=#444444
" autocmd ColorScheme * highlight IncSearch cterm=none ctermfg=7 gui=none guifg=#555555
autocmd ColorScheme * highlight SpellBad cterm=underline ctermfg=210 ctermbg=23 gui=underline guifg=#fd8489 guisp=#fd8489
autocmd ColorScheme * highlight Visual ctermbg=132 guibg=#a9667a
" autocmd ColorScheme * highlight Search cterm=underline ctermbg=132 guibg=#a9667a
" autocmd ColorScheme * highlight ALEError ctermbg=167 guibg=#ab6560
autocmd ColorScheme * highlight ALEError ctermbg=89 guibg=#ab6560
" autocmd ColorScheme * highlight ALEErrorSign cterm=bold ctermfg=235 ctermbg=167 gui=bold guifg=#3a4b5c guibg=#ab6560
autocmd ColorScheme * highlight ALEErrorSign cterm=bold ctermfg=235 ctermbg=89 gui=bold guifg=#3a4b5c guibg=#ab6560
autocmd VimEnter,WinEnter * let w:m1 = matchadd("TabString", '	')
autocmd VimEnter,WinEnter * let w:m2 = matchadd("ZenkakuSpace", '　')
autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
autocmd VimEnter,WinEnter *.py syntax keyword Special self

augroup vimrc-todo
  autocmd!
  autocmd Syntax * syn match myTodo /\v<(HACK|NB):?/ containedin=.*Comment
augroup END
highlight def link myTodo Todo

if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
    \                 | echomsg 'startuptime: ' . reltimestr(g:startuptime)
  augroup END
endif
autocmd WinEnter * checktime

autocmd SwapExists * let v:swapchoice = 'o'

augroup vimrc-misc
  autocmd!
  autocmd BufReadPost
  \ * if line("'\"") && line("'\"") <= line('$')
  \ |   execute 'normal! g`"'
  \ | endif
augroup END

function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

" key mapping{{{1
set pastetoggle=<F2>
nnoremap <F3> :setlocal spell! spell?<CR>
inoremap <F3> <C-o>:setlocal spell! spell?<CR>
noremap ; :
"nnoremap <silent><Space> <PageDown>
nnoremap <silent><C-Space> <C-w>p<PageDown><C-w>p
nnoremap <C-w>* <C-w>s*
nnoremap <C-w># <C-w>s#
nnoremap Y y$
nnoremap <silent><C-j> :<C-u>bnext<CR>
nnoremap <silent><C-k> :<C-u>bprevious<CR>
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
inoremap <C-j> <CR>
cnoremap <C-j> <CR>
inoremap <C-h> <BS>
inoremap <M-d> <C-o>de
inoremap <C-f> <C-o>l
inoremap <M-f> <C-o>w
inoremap <C-b> <C-o>h
inoremap <M-b> <C-o>b
" inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-_> <ESC>
inoremap <C-/> <ESC>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
" inoremap <C-r>+ <C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>
inoremap <C-d> <C-o>x

function! ToggleSigncolumn() abort
  if &signcolumn == 'yes'
    let &signcolumn = 'no'
  else
    let &signcolumn = 'yes'
  endif
endfunction
nnoremap <F1> :call ToggleSigncolumn()<CR>

" filetype detect settings{{{1
autocmd BufNewFile,BufRead *.dart set filetype=dart
autocmd BufNewFile,BufRead *.io set filetype=io
autocmd BufNewFile,BufRead lighttpd.conf set filetype=lighttpd
autocmd BufNewFile,BufRead *.m set filetype=objc
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd BufNewFile,BufRead *.{atd,mly,mlt} set filetype=ocaml
autocmd BufNewFile,BufRead *.{cgi,t} set filetype=perl
autocmd BufNewFile,BufRead *.scala set filetype=scala
autocmd BufNewFile,BufRead *.swift set filetype=swift
autocmd BufNewFile,BufRead *.test set filetype=text
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.toml set filetype=toml

" vim-plug{{{1
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'nixprime/cpsm', { 'do' : 'PY3=ON ./install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'AndrewRadev/linediff.vim'
if has('nvim')
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \}
else
  Plug 'w0rp/ale', { 'for' : ['c', 'cpp', 'cmake', 'css', 'go', 'java', 'javascript', 'ocaml', 'python', 'rust', 'r', 'scss', 'sh'] }
endif
"Plug 'haya14busa/vim-open-googletranslate', { 'on' : 'OpenGoogleTranslate' }
Plug 'haya14busa/vim-asterisk'
"Plug 'jeetsukumaran/vim-markology'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-smartword'
Plug 'kana/vim-submode'
Plug 'tyru/open-browser.vim' | Plug 'kannokanno/previm', { 'for' : ['markdown', 'rst'] }
Plug 'osyo-manga/vim-anzu'
Plug 'r6eve/tcvime'
Plug 'r6eve/vim-shina'
Plug 'Shougo/vimproc.vim' | Plug 'rhysd/clever-f.vim'
Plug 'Shougo/vimproc.vim' | Plug 'rhysd/committia.vim'
Plug 'rhysd/github-complete.vim', { 'for' : ['markdown', 'rst'] }
Plug 'rhysd/vim-color-spring-night'
Plug 'rhysd/vim-gfm-syntax'
"Plug 'rhysd/vim-grammarous', { 'on' : 'GrammarousCheck' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'sgur/vim-editorconfig'
Plug 'Shougo/neosnippet.vim'
"Plug 'thinca/vim-prettyprint'
Plug 'thinca/vim-qfreplace', { 'on' : 'Qfreplace' }
Plug 'Shougo/vimproc.vim' | Plug 'thinca/vim-quickrun', { 'on' : 'QuickRun' }
Plug 'thinca/vim-template'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
"Plug 'tyru/capture.vim', { 'on' : 'Capture' }
"Plug 'r6eve/caw.vim', { 'branch': 'add-feature-to-delete-doc-comments' }
Plug 'tyru/caw.vim'
Plug 'Shougo/vimproc.vim' | Plug 'tyru/open-browser.vim'
Plug 'vim-scripts/gtags.vim'
" C++
Plug 'vim-jp/vim-cpp', { 'for' : 'cpp' }
Plug 'rhysd/vim-clang-format', { 'for' : ['c', 'cpp'] }
" Clojure
if has('nvim')
  Plug 'clojure-vim/async-clj-omni', { 'for' : 'clojure' }
  Plug 'tpope/vim-salve', { 'for' : 'clojure' }
  Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }
  Plug 'venantius/vim-cljfmt', { 'for' : 'clojure' }
  Plug 'venantius/vim-eastwood', { 'for' : 'clojure' }
  Plug 'vim-syntastic/syntastic', { 'for' : 'clojure' }
else
  Plug 'ctrlpvim/ctrlp.vim', { 'for' : 'clojure' }
  Plug 'guns/vim-sexp', {'for': 'clojure' }
  Plug 'liquidz/vim-iced', {'for': 'clojure' }
endif
" D
"Plug 'landaire/deoplete-d', { 'for' : 'd' }
" Go
"Plug 'fatih/vim-go', { 'for' : 'go' }
" HTML
Plug 'mattn/emmet-vim', { 'for' : ['jsp', 'html', 'haml', 'xhtml', 'liquid', 'css', 'scss', 'sass'] }
" Java
"Plug 'artur-shaik/vim-javacomplete2', { 'for' : 'java' }
" JavaScript
"Plug 'jelera/vim-javascript-syntax', { 'for' : ['javascript'] }
Plug 'posva/vim-vue', { 'for': ['javascript', 'html'] }
Plug 'gavocanov/vim-js-indent', { 'for' : ['javascript', 'html'] }
" lighttpd
"Plug 'glensc/vim-syntax-lighttpd', { 'for' : 'lighttpd' }
" Perl
Plug 'c9s/perlomni.vim', { 'for' : 'perl' }
Plug 'vim-perl/vim-perl'
" Python
Plug 'vim-scripts/python_match.vim', { 'for' : 'python' }
" Ruby
Plug 'kana/vim-smartinput' | Plug 'cohama/vim-smartinput-endwise', { 'for' : 'ruby' }
" Rust
Plug 'rust-lang/rust.vim'
" Scala
"Plug 'derekwyatt/vim-scala', { 'for' : 'scala' }
" Scheme
"Plug 'aharisu/vim_goshrepl', { 'for' : 'scheme' }
" Shell script
Plug 'vim-scripts/sh.vim', { 'for' : 'sh' }
" Swift
"Plug 'Keithbsmiley/swift.vim', { 'for' : 'swift' }
" TOML
Plug 'cespare/vim-toml', { 'for' : 'toml' }
" TypeScript
"Plug 'Quramy/tsuquyomi', { 'for' : 'typescript' }
Plug 'leafgarland/typescript-vim', { 'for' : 'typescript' }
" Vim Script
"Plug 'kannokanno/vmock', { 'for' : 'vim' }
"Plug 'thinca/vim-themis', { 'for' : 'vim' }

" textobjs
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-user' | Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-datetime'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user' | Plug 'sgur/vim-textobj-parameter'
Plug 'kana/vim-textobj-user' | Plug 'thinca/vim-textobj-between'

" operators
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-user' | Plug 'kana/vim-operator-replace'

call plug#end()

" advanced settings{{{1
" Shougo/deoplete.nvim{{{2
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\w*'
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.ocaml = ['[^. *\t]\.\w*', '[a-zA-Z_]\w*']
let g:deoplete#omni#functions = {}
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-e> deoplete#cancel_popup()

" Shougo/denite.nvim{{{2
call denite#custom#map(
  \ 'insert',
  \ '<C-j>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<C-k>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)
call denite#custom#source(
  \ 'file_mru', 'matchers', ['matcher_cpsm', 'matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source(
  \ 'file_rec', 'matchers', ['matcher_cpsm'])
call denite#custom#option('default', 'prompt', '>')

" AndrewRadev/linediff.vim{{{2
vnoremap <silent><Leader>d :Linediff<CR>

" Language Server Protocol{{{2
if has('nvim')
  " autozimu/LanguageClient-neovim
  " \ 'clojure': ['bash', '-c', 'clojure-lsp'],
  let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd'],
    \ 'go': ['go-langserver'],
    \ 'javascript': ['/usr/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ 'typescript': ['/usr/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'php': ['php', $HOME.'/.config/composer/vendor/bin/php-language-server.php'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }

  autocmd FileType cpp,go,javascript,ocaml,php,python,rust,typescript set signcolumn=yes

  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_diagnosticsList = "location"

  autocmd FileType cpp,go,javascript,ocaml,php,python,rust,typescript nnoremap <silent>K :call LanguageClient_textDocument_hover()<CR>
  autocmd FileType cpp,go,javascript,ocaml,php,python,rust,typescript nnoremap <silent><Leader>t :call LanguageClient_textDocument_definition()<CR>
  autocmd FileType cpp,go,javascript,ocaml,php,python,rust,typescript nnoremap <silent><Leader>s <C-w>s:call LanguageClient_textDocument_definition()<CR>
  autocmd FileType cpp,go,javascript,ocaml,php,python,rust,typescript nnoremap <silent><Leader>b :call LanguageClient_textDocument_documentSymbol()<CR>:Denite documentSymbol<CR>
else
  " w0rp/ale
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_set_balloons = 0
  let g:airline#extensions#ale#enabled = 0
  let g:ale_set_highlights = 0

  " Java
  " FIX: Does not work.
  " let g:ale_java_javalsp_jar = "/path/to/out/fat-jar.jar"

  " Rust
  let g:ale_rust_rls_toolchain = 'stable'

  " let g:ale_sign_column_always = 1 " Too slow.
  autocmd FileType c,cpp,cmake,css,go,java,javascript,ocaml,python,r,rust,scss,sh set signcolumn=yes

  let g:ale_fixers = {
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-format'],
    \ 'cmake': ['cmakelint'],
    \ 'css': ['prettier'],
    \ 'go': ['gofmt'],
    \ 'java': ['google_java_format'],
    \ 'javascript': ['prettier'],
    \ 'ocaml': ['ocamlformat'],
    \ 'python': ['yapf'],
    \ 'rust': ['rustfmt'],
    \ 'scss': ['prettier'],
    \ 'sh': ['shfmt'],
    \ }

  let g:ale_linters = {
    \ 'python': ['pyls'],
    \ }

  autocmd FileType c,cpp,cmake,css,go,java,javascript,ocaml,python,r,rust,scss,sh nmap <silent>K <Plug>(ale_find_references)
  autocmd FileType c,cpp,cmake,css,go,java,javascript,ocaml,python,r,rust,scss,sh nmap <silent><Leader>f <Plug>(ale_fix)
  autocmd FileType cpp,cmake,css,go,javascript,ocaml,python,r,rust,scss,sh nmap <silent><C-]> <Plug>(ale_go_to_definition)
  autocmd FileType cpp,cmake,css,go,javascript,ocaml,python,r,rust,scss,sh nmap <silent><Leader>s <C-w>s<Plug>(ale_go_to_definition)
  autocmd FileType cpp,cmake,css,go,javascript,ocaml,python,r,rust,scss,sh nmap <silent><C-T> <C-O>
endif

" haya14busa/vim-asterisk{{{2
map *   <Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
map #   <Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
map g*  <Plug>(asterisk-*)<Plug>(anzu-update-search-status-with-echo)
map g#  <Plug>(asterisk-#)<Plug>(anzu-update-search-status-with-echo)
map z*  <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
map gz* <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
map z#  <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)
map gz# <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)

let g:asterisk#keeppos = 1

"" ctrlpvim/ctrlp.vim{{{2
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_custom_ignore = { 'dir': '\v[\/]\.(git|hg|svn)$', 'file': '\v\.(exe|so|dll|swp|pdf|DS_Store)$', }
" let g:ctrlp_max_files = 500
" let g:ctrlp_max_depth = 5
" let g:ctrlp_open_new_file = 'h'
" let g:ctrlp_tilde_homedir = 1
" let g:ctrlp_follow_symlinks = 2

" r6eve/tcvime{{{2
" let tcvime_keymap = 'tcode'
let tcvime_keymap = 'gcode'
let tcvime_no_default_key_mappings = 1
imap <unique> <silent> <C-a>q <Plug>TcvimeIStart
imap <unique> <silent> <C-a><Space> <Plug>TcvimeIConvOrStart
imap <unique> <silent> <C-a>a <Plug>TcvimeIDisableKeymap
nmap <unique> <silent> <C-a>? <Plug>TcvimeNHelp
" let plugin_tcvime_disable = 1

"" haya14busa/vim-open-googletranslate{{{2
"let g:opengoogletranslate#default_lang = 'ja'

"" jeetsukumaran/vim-markology{{{2
"let g:markology_enable = 0
"let g:markology_disable_mappings = 1
"nmap <silent>m! <Plug>MarkologyToggle
"nmap <silent>m? <Plug>MarkologyLocationList

" kana/vim-smartinput{{{2
call smartinput#map_to_trigger('i', '<C-h>', '<BS>', '<C-h>')
call smartinput#map_to_trigger('i', '<BS>', '<BS>', '<BS>')
call smartinput#map_to_trigger('i', '<C-j>', '<CR>', '<C-j>')
call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#map_to_trigger('i', '*', '*', '*')
" apostrophe
call smartinput#define_rule({
\  'at' : '\%#',
\  'char' : '''',
\  'input' : '''',
\  'filetype' : ['factor', 'ocaml', 'rust'],
\})
call smartinput#define_rule({
\  'at' : '\%#',
\  'char' : '''',
\  'input' : '''',
\  'syntax' : ['Constant'],
\  'filetype' : ['factor', 'ocaml', 'rust'],
\})
" paren
call smartinput#define_rule({
\  'at' : '(\%#)',
\  'char' : '<Space>',
\  'input' : '<Space><Space><Left>',
\})
call smartinput#define_rule({
\  'at' : '( \%# )',
\  'char' : '<BS>',
\  'input' : '<Del><BS>',
\})
call smartinput#define_rule({
\  'at' : '(\%#)',
\  'char' : '*',
\  'input' : '*<Space>*<Left><Left><Space>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '(\* \%# \*)',
\  'char' : '*',
\  'input' : '<BS>*<Space>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '(\* \%# \*)',
\  'char' : '<BS>',
\  'input' : '<BS><BS><BS><Del><Del><Del>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '(\*\* \%# \*)',
\  'char' : '<BS>',
\  'input' : '<BS><BS><BS><BS><Del><Del><Del>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '(\* \%# \*)',
\  'char' : '<Enter>',
\  'input' : '<BS><Enter><ENTER><BS><BS><BS><Del><Up><ESC>"_S',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '(\*\* \%# \*)',
\  'char' : '<Enter>',
\  'input' : '<BS><Enter><ENTER><BS><BS><BS><Del><Up><ESC>"_S',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\%#\_s*\*)',
\  'char' : ')',
\  'input' : '<C-r>=smartinput#_leave_block('')'')<Enter><Right>',
\  'filetype' : ['ocaml'],
\})
" " less
" " TODO: cannot work
" call smartinput#define_rule({
" \  'at' : '\%#',
" \  'char': '<lt>',
" \  'input': '<><Left>',
" \  'filetype' : ['rust'],
" \})
" call smartinput#define_rule({
" \  'at' : '\%#\_s*\>',
" \  'char' : '>',
" \  'input' : '<C-r>=smartinput#_leave_block(''>'')<Enter><Right>',
" \  'filetype' : ['rust'],
" \})
" bracket
call smartinput#define_rule({
\  'at' : '\[\%#\]',
\  'char' : '<Space>',
\  'input' : '<Space><Space><Left>',
\})
call smartinput#define_rule({
\  'at' : '\[ \%# \]',
\  'char' : '<BS>',
\  'input' : '<Del><BS>',
\})
call smartinput#define_rule({
\  'at' : '\[\%#\]',
\  'char' : '<Enter>',
\  'input' : '<Enter><Enter><Up><Esc>"_S',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\[\%#\]',
\  'char' : '<Bar>',
\  'input' : '<Bar><Bar><Left>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\%#\_s*|\]',
\  'char' : ']',
\  'input' : '<C-r>=smartinput#_leave_block('']'')<Enter><Right>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\[|\%#|\]',
\  'char' : '<BS>',
\  'input' : '<BS><BS><Del><Del>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\[||\]\%#',
\  'char' : '<BS>',
\  'input' : '<BS><BS><BS><BS>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\[|\%#|\]',
\  'char' : '<Space>',
\  'input' : '<Space><Space><Left>',
\  'filetype' : ['ocaml'],
\})
call smartinput#define_rule({
\  'at' : '\[| \%# |\]',
\  'char' : '<BS>',
\  'input' : '<Del><BS>',
\  'filetype' : ['ocaml'],
\})
" grave
call smartinput#define_rule({
\  'at' : '\%#',
\  'char' : '`',
\  'input' : '`',
\})
call smartinput#define_rule({
\  'at' : '\%#`',
\  'char' : '`',
\  'input' : '`',
\})
call smartinput#define_rule({
\  'at' : '`\%#`',
\  'char' : '<BS>',
\  'input' : '<BS>',
\})
call smartinput#define_rule({
\  'at' : '``\%#',
\  'char' : '<BS>',
\  'input' : '<BS>',
\})
call smartinput#define_rule({
\  'at' : '``\%#',
\  'char' : '`',
\  'input' : '`',
\})
call smartinput#define_rule({
\  'at' : '\%#```',
\  'char' : '`',
\  'input' : '`',
\})
call smartinput#define_rule({
\  'at' : '```\%#```',
\  'char' : '<BS>',
\  'input' : '<BS>',
\})
call smartinput#define_rule({
\  'at' : '``````\%#',
\  'char' : '<BS>',
\  'input' : '<BS>',
\})
" brace
call smartinput#define_rule({
\  'at' : '{\%#}',
\  'char' : '<Space>',
\  'input' : '<Space><Space><Left>',
\})
call smartinput#define_rule({
\  'at' : '{ \%# }',
\  'char' : '<BS>',
\  'input' : '<Del><BS>',
\})
" bar
call smartinput#define_rule({
\  'at' : '\%#',
\  'char' : '<Bar>',
\  'input' : '<Bar><Bar><Left>',
\  'filetype' : ['rust'],
\})
call smartinput#define_rule({
\  'at' : '\%#\_s*|',
\  'char' : '<Bar>',
\  'input' : '<C-r>=smartinput#_leave_block(''|'')<Enter><Right>',
\  'filetype' : ['rust'],
\})
call smartinput#define_rule({
\  'at' : '|\%#|',
\  'char' : '<BS>',
\  'input' : '<BS><BS><Del><Del>',
\  'filetype' : ['rust'],
\})
call smartinput#define_rule({
\  'at' : '||\%#',
\  'char' : '<BS>',
\  'input' : '<BS><BS><BS><BS>',
\  'filetype' : ['rust'],
\})
call smartinput#define_rule({
\  'at' : '|\%#|',
\  'char' : '<Space>',
\  'input' : '<Space><Space><Left>',
\  'filetype' : ['rust'],
\})
call smartinput#define_rule({
\  'at' : '| \%# |',
\  'char' : '<BS>',
\  'input' : '<Del><BS>',
\  'filetype' : ['rust'],
\})

" kana/vim-smartword{{{2
nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
xmap w <Plug>(smartword-w)
xmap b <Plug>(smartword-b)
xmap e <Plug>(smartword-e)
xmap ge <Plug>(smartword-ge)

" kana/vim-submode{{{2
let g:submode_keep_leaving_key = 1
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
call submode#enter_with('change-list', 'n', '', 'g;', 'g;')
call submode#enter_with('change-list', 'n', '', 'g,', 'g,')
call submode#map('change-list', 'n', '', ';', 'g;')
call submode#map('change-list', 'n', '', ',', 'g,')
call submode#enter_with('move-to-fold', 'n', '', 'zj', 'zj')
call submode#enter_with('move-to-fold', 'n', '', 'zk', 'zk')
call submode#map('move-to-fold', 'n', '', 'j', 'zj')
call submode#map('move-to-fold', 'n', '', 'k', 'zk')

" kannokanno/previm{{{2
autocmd Filetype markdown,rst nmap <Leader>p :<C-u>PrevimOpen<CR>

" osyo-manga/vim-anzu{{{2
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)

" tyru/caw.vim{{{2
let g:caw_no_default_keymappings = 1
let g:caw_dollarpos_sp_left = ' '
autocmd FileType python let g:caw_dollarpos_sp_left = '  '
map gci <Plug>(caw:hatpos:comment)
map gcui <Plug>(caw:hatpos:uncomment)
map gca <Plug>(caw:dollarpos:comment)
map gcua <Plug>(caw:dollarpos:uncomment)
map gcw <Plug>(caw:wrap:comment)
map gcuw <Plug>(caw:wrap:uncomment)
map gco <Plug>(caw:jump:comment-next)
map gcO <Plug>(caw:jump:comment-prev)

" rhysd/clever-f.vim{{{2
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
let g:clever_f_use_migemo = 1
if has('nvim')
  let g:clever_f_hide_cursor_on_cmdline = 0
endif

" rhysd/committia.vim{{{2
let g:committia_hooks = {}
let g:committia_min_window_width = 120
function! g:committia_hooks.edit_open(info)
  setlocal spell
  imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
  imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" rhysd/vim-color-spring-night{{{2
colorscheme spring-night

"" rhysd/vim-grammarous{{{2
"let g:grammarous#default_comments_only_filetypes = {
"            \ '*' : 1, 'help' : 0, 'markdown' : 0,
"            \ }
"let g:grammarous#disabled_rules = {
"            \ '*' : ['EN_QUOTES', 'UPPERCASE_SENTENCE_START', 'WHITESPACE_RULE'],
"            \ }

" Shougo/neosnippet{{{2
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neosnippet#snippets_directory='~/.vim/snippets'

" thinca/vim-quickrun{{{2
nnoremap <silent><Leader>r :<C-u>QuickRun<CR>
let g:quickrun_config = {
  \  '_' : {
  \    'runner' : 'vimproc',
  \    'runner/vimproc/updatetime' : 500
  \  },
  \  'c' : {
  \    'cmdopt' : '-std=c99 -O2 -Wall -Wextra -pedantic -Wformat=2 -Wstrict-aliasing=2'
  \  },
  \  'cpp' : {
  \    'cmdopt' : '-std=c++11 -O2 -Wall -Wextra -pedantic -Wformat=2 -Wstrict-aliasing=2'
  \  },
  \  'lisp' : { 'command' : 'sbcl' },
  \  'r': {
  \    'command': 'Rscript',
  \    'exec' : '%c %o --no-save --slave %s %a'
  \  },
  \  'st' : { 'command' : 'gst' },
  \  'scheme' : { 'command' : 'gosh' }
  \}

" tyru/open-browser{{{2
nmap <Leader>o <Plug>(openbrowser-smart-search)
vmap <Leader>o <Plug>(openbrowser-smart-search)
let g:openbrowser_open_filepath_in_vim = 0
command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')
nmap <Leader>O :<C-u>OpenBrowserCurrent<CR>
if has('unix')
  let g:openbrowser_browser_commands = [
  \  { 'name' : 'firefox',
  \    'cmd' : 'firefox',
  \    'args' : ['{browser}', '--private-window', '{uri}'] },
  \  { 'name' : 'google-chrome-stable',
  \    'cmd' : 'google-chrome-stable',
  \    'args' : ['{browser}', '--incognito', '{uri}'] },
  \  { 'name' : 'xdg-open',
  \    'cmd' : 'xdg-open',
  \    'args' : ['{browser}', '{uri}'] },
  \  { 'name' : 'x-www-browser',
  \    'cmd' : 'x-www-browser',
  \    'args' : ['{browser}', '{uri}'] },
  \  { 'name' : 'w3m',
  \    'cmd' : 'w3m',
  \    'args' : ['{browser}', '{uri}'] },
  \]
endif

" kana/vim-operator-replace{{{2
map _ <Plug>(operator-replace)

" vim-scripts/gtags.vim{{{2
autocmd FileType c,cpp nmap <silent><Leader>g :Gtags -f %<CR>

" C/C++{{{2
autocmd FileType c,cpp nmap <silent><Leader>f :ClangFormat<CR>

" Clojure{{{2
if has('nvim')
  " venantius/vim-cljfmt
  autocmd FileType clojure nmap <silent><Leader>f :Cljfmt<CR>
  let g:clj_fmt_autosave = 0

  " vim-syntastic/syntastic
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_always_populate_loc_list = 0
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_clojure_checkers = ['eastwood']
  autocmd FileType clojure set signcolumn=yes
else
  " guns/vim-sexp
  let g:sexp_mappings = {'sexp_indent': '', 'sexp_indent_top': ''}

  " liquidz/vim-iced
  let g:iced#buffer#stdout#file = '/tmp/vim-iced.clj'

  let g:iced#format#rule = {
      \ 'merr.core/let': '[[:block 2] [:inner 1]]',
      \ }

  let g:iced#eastwood#option = {
      \ 'linters': ['all'],
      \ }
  let g:iced_enable_auto_linting = v:true
  autocmd FileType clojure set signcolumn=yes

  autocmd FileType clojure silent! nmap <buffer><Leader>st <Plug>(iced_toggle_src_and_test)

  let g:iced_enable_default_key_mappings = v:true
endif

" Java{{{2
" let g:JavaComplete_EnableDefaultMappings = 0

" Fortran{{{2
let g:fortran_fixed_source=1
let g:fortran_more_precise=1

" HTML{{{2
let g:html_indent_inctags = "html,body,head,tbody"

" LaTeX{{{2
let g:tex_conceal=""
let g:tex_flavor='latex'
autocmd FileType tex set spell

" OCaml{{{2
if executable('ocamlmerlin') && has('python')
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  exec "set rtp+=" . g:opamshare . "/merlin/vim"
end
autocmd FileType ocaml set commentstring=(*%s*)
autocmd BufNewFile,BufRead *.mly syn region ocamlComment start="/\*" end="\*/" contains=@Spell,ocamlComment,ocamlTodo

" R{{{2
let vimrplugin_assign = 0
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" Ruby{{{2
let g:ruby_path = ""
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif
autocmd FileType ruby call smartinput_endwise#define_default_rules()

" Scheme{{{2
"autocmd FileType scheme vmap <C-j> <Plug>(gosh_repl_send_block)

" Shell script{{{2
let g:sh_indent_case_labels=1

" __END__{{{1
" vim: foldmethod=marker
