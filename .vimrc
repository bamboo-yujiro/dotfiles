"------ Encode ------"
set encoding=utf-8
if has('unix')
  set fileformat=unix
  set fileformats=unix,dos,mac
  set fileencoding=utf-8
  set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
  set termencoding=
elseif has('win32')
  set fileformat=dos
  set fileformats=dos,unix,mac
  set fileencoding=utf-8
  set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
  set termencoding=
endif
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\

" 設定ファイル（ignore対象）の読み込み
if filereadable(expand("~/dotfiles/.vimrc.local"))
  source ~/dotfiles/.vimrc.local
endif

"------ keymap ------"
inoremap <C-c> <ESC>
inoremap <C-b> <left>
inoremap <C-f> <right>
inoremap <C-p> <up>
inoremap <C-n> <down>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-e> <END>
inoremap <C-a> <HOME>
inoremap <C-k> <ESC><RIGHT>Da

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

nnoremap gj j
nnoremap gk k

"send to clipboard"
vnoremap <silent>y y :call system('nc localhost 8377', @0)<CR>
vnoremap <silent>d d :call system('nc localhost 8377', @1)<CR>

nnoremap <F5> :<C-u>edit $MYVIMRC<Enter>
nnoremap <F6> :<C-u>source $MYVIMRC<Enter>

nnoremap <C-g> 1<C-g>

"noremap <C-r> :%s/"
"cnoremap <C-r> :%s/"
"inoremap <C-r> <ESC>:%s/"

set pastetoggle=<F10>

autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END


"------ Format ------"
" 対応する括弧やブレースを表示する
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 改行時に前の行のインデントを継続する
set autoindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" ファイル内の <Tab> が対応する空白の数
set tabstop=2
"set tabstop=4"
" シフト移動幅
set shiftwidth=2
"set shiftwidth=4
" Tab入力時半角スペースにする
set expandtab
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" 行番号の表示する
set number
" 常にカーソル行を真ん中に
set scrolloff=999
" カレント行をハイライト
set cursorline
" 入力中のコマンドを表示する
set showcmd
" Bs で消せるものを指定する
set backspace=start,eol,indent
" 矩形選択を空白も選択できる
set virtualedit+=block
" swap ファイルを生成しない
set noswapfile
" 補完表示
 set wildmenu
" 補完候補を一覧で表示
 set wildmode=list:full
" ノーマルモード時にペーストモードを解除する
autocmd InsertLeave * set nopaste
" clipboard+ の時に yank でクリップボードにコピー
" set clipboard=unnamedplus,autoselect
" ターミナル接続を高速にする
set ttyfast
" マクロを実行中は描画を中段する
set lazyredraw
" オンのときは、ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap

"余計な文字を削除する
function! s:remove_dust()
    let cursor = getpos(".")
    " 保存時に行末の空白を除去する
    %s/\s\+$//ge
    " 保存時にtabを2スペースに変換する
    %s/\t/  /ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

"------ Search ------"
" インクリメンタルサーチ
set incsearch
" 検索時に大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視, 大文字が入ると ignorecase が無効になる
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索する
set wrapscan
" 検索結果のハイライト
set hlsearch
" EscEsc でハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

au BufRead,BufNewFile *.md set filetype=markdown

"------ Dein.vim ------"
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"" ------ ColorScheme ------"
syntax on
"filetype plugin indent on
set background=dark
colorscheme hybrid

" Syntax 設定
"let g:syntastic_python_checkers = ['pyflakes']
"let g:syntastic_enable_perl_checker = 1
"let g:syntastic_perl_checkers = ['perl', 'podchecker']
"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_ruby_checkers = ['rubocop']

let g:vim_json_syntax_conceal = 0
let g:indentLine_color_term = 239
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Nerdtree
nmap <silent> <C-e>      :NERDTreeToggle<CR>
"vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
"omap <silent> <C-e>      :NERDTreeToggle<CR>
"imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
"cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1

"------ neocomplete ------"
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
" 補完ウィンドウの設定
set completeopt=menuone
" 補完ウィンドウの設定
set completeopt=menuone
" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'
" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1
" 最初の補完候補を選択状態にする => 無効
" let g:neocomplcache_enable_auto_select = 1
" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20
" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3
" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Enter で決定
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

"" neocomplcache
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


" 各ファイルフォーマットごとの設定
autocmd Filetype json setl conceallevel=0

autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict

" 各ファイルフォーマットタブインデント数のデフォルト値
if !exists("php_tabnum") | let php_tabnum = 4 | endif
if !exists("python_tabnum") | let python_tabnum = 4 | endif
if !exists("ruby_tabnum") | let ruby_tabnum = 2 | endif
if !exists("perl_tabnum") | let perl_tabnum = 4 | endif

autocmd FileType php,ctp execute "set tabstop=".php_tabnum
autocmd FileType php,ctp execute "set shiftwidth=".php_tabnum

autocmd FileType python execute "set tabstop=".python_tabnum
autocmd FileType python execute "set shiftwidth=".python_tabnum

set synmaxcol=1000

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

" Unite スタート時はインサートモードにしない
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uf :<C-u>Unite file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

autocmd BufEnter * :syntax sync fromstart
autocmd BufNewFile,BufRead *.slim set ft=slim

" Airline の設定
set t_Co=256
let g:airline_theme="luna"
let g:airline_powerline_fonts = 1
