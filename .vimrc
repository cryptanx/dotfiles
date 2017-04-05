if 0 | endif

if &compatible
    set nocompatible
endif

augroup MyAutoCmd
    autocmd!
augroup END

" dein settings {{{

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.config/nvim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

if dein#load_state(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim/')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  
  call dein#begin(s:dein_dir)
  cd $HOME/Documents
  "call dein#add('scrooloose/nerdtree')
  "autocmd VimEnter * execute 'NERDTree'
  
  call dein#end()
  call dein#save_state()
  
if dein#check_install()
  call dein#install()
endif

endif

let g:precious_enable_switch_CursorMoved = { '*': 0, 'help': 1 }
"autocmd MyAutoCmd InsertEnter * :PreciousSwitch
"autocmd MyAutoCmd InsertLeave * :PreciousReset

"-------------------------------------------------------------------------------
" neocomplete
"-------------------------------------------------------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\ }

let g:neocomplete#keyword_patterns = {}
let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
vmap <CR> <Plug>(gosh_repl_send_block)

" Use neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"

" With neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

" With deoplete.nvim
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

call dein#clear_state()

set encoding=utf-8
scriptencoding utf-8
set fileencoding=uft-8   " カレントバッファのファイルの文字エンコーディング 
set fileencodings=uft-8  " 既存のファイルの編集を開始するときに考慮される文字エンコーディングのリスト
set hlg=ja

"General Settings
set cindent
set cinoptions=g0 "indent for c++'s class
set smartindent
set title
set mouse=a
"set ttymouse=xterm2

"Edit Settings
set tabstop=4
set shiftwidth=4
set expandtab     "replace tab to spaces
set showmatch     "auto complete )
set matchtime=1   "wait time for showmatch
set backspace=indent,eol,start
set virtualedit=block "矩形選択時に文字が存在しなくてもカーソルを右へ進める
"行末までをヤンク
nnoremap Y y$     

"Display Settings
set number
set list
set listchars=eol:↲,tab:▸\
set ruler
set wrap
set shellslash

"Search Settings
set hlsearch       "enable highligt
set incsearch      "enable incremental search
set smartcase      "enable smart case
set grepprg=grep\ -nH\ $*

"Plugin Settings
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on


"split like tmux
noremap <C-w>% :vsp<CR>
noremap <C-w>" :sp<CR>
noremap <C-w>p :tabp<CR>
noremap <C-w>n :tabn<CR>
noremap <C-w>c :tabnew<CR>

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
"if has('unnamedplus')
"    set clipboard& clipboard+=unnamedplus
"else
"    set clipboard& clipboard+=unnamed
"endif

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
au BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)


"neocomplete Settings
"let s:hooks = neobundle#get_hooks("neocomplete.vim")
"function! s:hooks.on_source(bundle)
"    let g:neocomplete#enable_smart_case = 1
"    let g:neocomplete#enable_at_startup = 0
"endfunction

autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

"set cursorline
set nobackup

" スペース+'.'で.vimrc_localを開く
nnoremap <Space>. :<C-u>tabedit ~/.config/nvim/dein.toml<CR>

" スペース+','で.vimrcを開く
"nnoremap <Space>, :<C-u>tabedit ~/.vimrc<CR>
nnoremap <Space>, :<C-u>tabedit ~/.config/nvim/init.vim<CR>

" 検索時に大文字小文字に関わらず検索する
set ignorecase
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
 "   (例: DOS/Windows/MacOS)
 "
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
    set tags=./tags,tags
endif

set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー


" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()


"改行時にコメント自動で挿入するのを解除
autocmd FileType * setlocal formatoptions-=ro

"zencoding
let g:user_zen_expandabbr_key = '<c-r>'

"*****************************************************************************"
"NeoBundle.vimのプラグイン
"filetype off
"set nocompatible " be iMproved
"if has('vim_starting')
"  set runtimepath+=~/.vim/bundle/neobundle.vim
"    call neobundle#begin(expand('~/.vim/bundle/'))
"endif
"
"NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'itchyny/lightline.vim'
"NeoBundle 'Shougo/vimfiler.vim'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/neomru.vim'
"NeoBundle 'osyo-manga/vim-over'
"NeoBundle 'Shougo/neosnippet.git'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/vimproc', {
"            \ 'build' : {
"            \ 'windows' : 'make -f make_mingw32.mak',
"            \ 'cygwin' : 'make -f make_cygwin.mak',
"            \ 'mac' : 'make -f make_mac.mak',
"            \ 'unix' : 'make -f make_unix.mak',
"            \ },
"            \ }
""NeoBundle 'Align'
"NeoBundle 'junegunn/vim-easy-align'
"NeoBundle 'Yggdroot/indentLine'
"NeoBundle 'Shougo/unite-outline'
"NeoBundle 'hynek/vim-python-pep8-indent'
"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'jonathanfilip/vim-lucius'
"
"" jedi-vim
""NeoBundle 'davidhalter/jedi-vim'
""let g:jedi#popup_on_dot = 1
"NeoBundleLazy "davidhalter/jedi-vim", {
"            \ "autoload": {
"            \   "filetypes": ["python", "python3", "djangohtml"],
"            \ },
"            \ "build": {
"            \   "mac": "pip install jedi",
"            \   "unix": "pip install jedi",
"            \ }}
"
"" if_luaが有効ならneocompleteを使う
"NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
"
"call neobundle#end()
"filetype plugin indent on
"*****************************************************************************"


"python用設定
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=4 shiftwidth=4 softtabstop=4
set guifont=Ricty:h14
au BufEnter *.py setlocal indentkeys+=0#
autocmd FileType python :inoremap # a<C-H># 

" クリップボードとvimを共有
"set clipboard=unnamed,autoselect
"set clipboard+=unnamed
"set clipboard+=autoselect


"lightline.vim設定
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            return fugitive#head()
        endif
    catch
    endtry
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Esc Esc でハイライトOFF
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>

nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?                
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#

augroup auto_comment_off
        autocmd!
            autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" powerlineのフォント設定
let g:Powerline_symbols = 'fancy'

" 文字コード
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

" Unite
let g:unite_source_file_mru_limit = 200
nnoremap <silent> <Space>k :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> ,kk :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" バッファーと履歴
nnoremap <silent> <Space>u :<C-u>Unite file_mru buffer<CR>
"nnoremap <silent> ,ku :<C-u>Unite file_mru buffer<CR>

" Neosnippet" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"

"Conceal機能を無効化
let g:tex_conceal=''

" beamerをコンパイル
autocmd FileType tex noremap <buffer> <F9> :w<CR> :!beamer <C-R>%<CR>

" neocomplete
" completefuncを上書き
let g:neocomplcache_force_overwrite_completefunc = 1

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_auto_select = 0
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

"jediとneocomplete
autocmd FileType python setlocal omnifunc=jedi#completions
"let g:jedi#popup_select_first=0
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

" pythonにおいてdocstringは表示しない
autocmd FileType python setlocal completeopt-=preview

if !exists('g:neocomplete# force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
"let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" indentLine
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '¦' "use ¦, ┆ or │

" GNU GLOBAL(gtags)
nmap <C-q> <C-w><C-w><C-w>q
nmap <C-g> :Gtags -g
nmap <C-l> :Gtags -f %<CR>
nmap <C-m> :Gtags <C-r><C-w><CR>
"nmap <C-t> :GtagsCursor<CR>
nmap <C-k> :Gtags -r <C-r><C-w><CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
" Ctrl-q 検索結果Windowを閉じる
" Ctrl-g ソースコードの grep
" Ctrl-l このファイルの関数一覧
" Ctrl-j カーソル以下の定義元を探す
" Ctrl-m カーソル以下の使用箇所を探す
" Ctrl-n 次の検索結果へジャンプする
" Ctrl-p 前の検索結果へジャンプする

" 画面切り替え時等のみcursorlineを表示. 
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
    autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
    autocmd WinEnter * call s:auto_cursorline('WinEnter')
    autocmd WinLeave * call s:auto_cursorline('WinLeave')

    let s:cursorline_lock = 0
    function! s:auto_cursorline(event)
        if a:event ==# 'WinEnter'
            setlocal cursorline
            let s:cursorline_lock = 2
        elseif a:event ==# 'WinLeave'
            setlocal nocursorline
        elseif a:event ==# 'CursorMoved'
            if s:cursorline_lock
                if 1 < s:cursorline_lock
                    let s:cursorline_lock = 1
                else
                    setlocal nocursorline
                    let s:cursorline_lock = 0
                endif
            endif
        elseif a:event ==# 'CursorHold'
            setlocal cursorline
            let s:cursorline_lock = 1
        endif
    endfunction
augroup END

" unite outline
nnoremap <silent> <Space>o : <C-u>Unite -no-quit -vertical -winwidth=40 outline<CR> 
"- See more at: http://syotaro.ruhoh.com/posts/20121216-tips-vim-outliner/#sthash.Lvzhf2ot.dpuf
let g:unite_source_outline_filetype_options = {
            \ '*': {
            \   'auto_update': 1,
            \   'auto_update_event': 'write',
            \ },
            \ 'tex': {
            \   'auto_update_event': 'hold',
            \ },
            \}

set t_Co=256

"Color Scheme
"colorscheme lucius
"set background=dark

let g:syntastic_python_checkers = ['pyflakes', 'pep8']


colorscheme lucius
set background=dark
syntax on
