"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       _       _
"      (_)   __(_)___ ___
"     / / | / / / __ `__ \
"    / /| |/ / / / / / / /
"   /_/ |___/_/_/ /_/ /_/
"
"   Main Contributor: Guangda Zhang (inkless) <zhangxiaoyu9350@gmail.com>
"   Version: 2.5
"   Created: 2012-01-20
"   Last Modified: 2016-07-01
"
"   Sections:
"     -> ivim Setting
"     -> General
"     -> Platform Specific Setting
"     -> Vim-plug
"     -> User Interface
"     -> Colors and Fonts
"     -> Indent Related
"     -> Search Related
"     -> Fold Related
"     -> Key Mapping
"     -> Plugin Setting
"     -> Local Setting
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => ivim Setting
"------------------------------------------------

" ivim user setting
let g:ivim_user='Guangda Zhang' " User name
let g:ivim_email='zhangxiaoyu9350@gmail.com' " User email
let g:ivim_github='https://github.com/inkless' " User github

" ivim color settings (OceanNext, PaperColor, hybrid, gruvbox or tender)
let g:ivim_default_scheme='gruvbox'
" ivim ui setting
let g:ivim_fancy_font=1 " Enable using fancy font
let g:ivim_show_number=1 " Enable showing number
" let g:ivim_autocomplete='YCM'
" ivim plugin setting
let g:ivim_bundle_groups=['ui', 'enhance', 'move', 'navigate',
            \'complete', 'compile', 'git', 'language']

" Customise ivim settings for personal usage
if filereadable(expand($HOME . '/.config/nvim/local.ivim.vim'))
    source $HOME/.config/nvim/local.ivim.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => General
"------------------------------------------------

" nvim
if has('macunix')
    set termguicolors
endif

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=

set nocompatible " Get out of vi compatible mode

filetype plugin indent on " Enable filetype
let mapleader=',' " Change the mapleader
let maplocalleader='\' " Change the maplocalleader
set timeoutlen=500 " Time to wait for a command

" Source the vimrc file after saving it
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>
nnoremap Q <Nop>

set autoread " Set autoread when a file is changed outside
set autowrite " Write on make/shell commands
set hidden " Turn on hidden"

set history=1000 " Increase the lines of history
set modeline " Turn on modeline
set encoding=utf-8 " Set utf-8 encoding
set completeopt+=longest " Optimize auto complete
set completeopt-=preview " Optimize auto complete

set backup " Set backup
set undofile " Set undo

" Set directories
function! InitializeDirectories()
    let parent=$HOME
    let prefix='/.local/share/nvim'
    let dir_list={
                \ 'backup': 'backupdir',
                \ 'view': 'viewdir',
                \ 'swap': 'directory',
                \ 'undo': 'undodir',
                \ 'cache': '',
                \ 'session': ''}
    for [dirname, settingname] in items(dir_list)
        let directory=parent.'/'.prefix.'/'.dirname.'/'
        if !isdirectory(directory)
            if exists('*mkdir')
                let dir = substitute(directory, "/$", "", "")
                call mkdir(dir, 'p')
            else
                echo 'Warning: Unable to create directory: '.directory
            endif
        endif
        if settingname!=''
            exe 'set '.settingname.'='.directory
        endif
    endfor
endfunction
call InitializeDirectories()

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Platform Specific Setting
"-------------------------------------------------
set viewoptions+=slash,unix " Better Unix/Windows compatibility
set viewoptions-=options " in case of mapping change

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Vim-Plug
"--------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

if count(g:ivim_bundle_groups, 'ui') " UI setting
    " Plug 'w0ng/vim-hybrid' " Colorscheme hybrid
    Plug 'morhetz/gruvbox' " Colorscheme gruvbox
    " Plug 'joshdick/onedark.vim'
    " Plug 'NLKNguyen/papercolor-theme'
    " Plug 'mhartington/oceanic-next'
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' " Status line
    Plug 'ryanoasis/vim-devicons' " Devicons
    Plug 'mhinz/vim-startify' " Start page
    Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
    Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing
endif

if count(g:ivim_bundle_groups, 'enhance') " Vim enhancement
    Plug 'Raimondi/delimitMate' " Closing of quotes
    Plug 'tomtom/tcomment_vim' " Commenter
    Plug 'tpope/vim-repeat' " Repeat
    Plug 'terryma/vim-multiple-cursors' " Multiple cursors
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Undo tree
    Plug 'tpope/vim-surround' " Surround
    Plug 'AndrewRadev/splitjoin.vim' " Splitjoin
    Plug 'sickill/vim-pasta' " Vim pasta
    Plug 'roman/golden-ratio' " Resize windows
    Plug 'chrisbra/vim-diff-enhanced' " Create better diffs
    Plug 'mhinz/vim-hugefile' " Largefile
    " Plug 'vim-scripts/YankRing.vim' "yank history for vim
    Plug 'amiorin/vim-project' " Project
    Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'scss', 'vim'] } " hmm
    Plug 'KabbAmine/vCoolor.vim' " Color Picker
    Plug 'godlygeek/tabular' " Vim script for text filtering and alignment
    Plug 'benmills/vimux' " Vim plugin to interact with tmux
endif

if count(g:ivim_bundle_groups, 'move') " Moving
    Plug 'tpope/vim-unimpaired' " Pairs of mappings
    Plug 'Lokaltog/vim-easymotion' " Easy motion
    Plug 'unblevable/quick-scope' " Quick scope
    Plug 'christoomey/vim-tmux-navigator' " Tmux navigation
endif

if count(g:ivim_bundle_groups, 'navigate') " Navigation
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " NERD tree
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } " NERD tree git plugin
    Plug 'ctrlpvim/ctrlp.vim' " Ctrl P Search
    Plug 'mileszs/ack.vim' " ack
endif

if count(g:ivim_bundle_groups, 'complete') " Completion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'carlitux/deoplete-ternjs'
    Plug 'ternjs/tern_for_vim'
    Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
    Plug 'zchee/deoplete-jedi'
    Plug 'sebastianmarkow/deoplete-rust'
endif

if count(g:ivim_bundle_groups, 'compile') " Compiling
    Plug 'w0rp/ale' " Async syntax checking
    " Plug 'xuhdev/SingleCompile' " Single compile
endif

if count(g:ivim_bundle_groups, 'git') " Git
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'tpope/vim-rhubarb' " Github extension for vim fugitive
    Plug 'gregsexton/gitv' " Gitk clone
    if has('signs')
        Plug 'airblade/vim-gitgutter' " Git diff sign
    endif
endif

if count(g:ivim_bundle_groups, 'language') " Language Specificity
    Plug 'sheerun/vim-polyglot' " Language Support (includes javascript and all other types)
    Plug 'davidhalter/jedi-vim', { 'for': 'python' } " Python jedi plugin
    " Plug 'tpope/vim-rails' " Rails
    Plug 'mattn/emmet-vim' " Emmet
    Plug 'heavenshell/vim-jsdoc' " JSDoc for vim
    Plug 'greyblake/vim-preview' " vim preview
    Plug 'tpope/vim-bundler' " gem bundler
    Plug 'editorconfig/editorconfig-vim'
    Plug 'slashmili/alchemist.vim'
    Plug 'elixir-editors/vim-elixir'
    Plug 'sukima/vim-ember-imports'
    Plug 'AndrewRadev/ember_tools.vim'
endif

if filereadable(expand($HOME . '/.config/nvim/local.bundles.vim')) " Load local bundles
    source $HOME/.config/nvim/local.bundles.vim
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => User Interface
"-------------------------------------------------

" Set title
set title
set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)

" Set tabline
set showtabline=2 " Always show tab line
" Set up tab labels
set guitablabel=%m%N:%t[%{tabpagewinnr(v:lnum)}]
set tabline=%!MyTabLine()
function! MyTabLine()
    let s=''
    let t=tabpagenr() " The index of current page
    let i=1
    while i<=tabpagenr('$') " From the first page
        let buflist=tabpagebuflist(i)
        let winnr=tabpagewinnr(i)
        let s.=(i==t ? '%#TabLineSel#' : '%#TabLine#')
        let s.='%'.i.'T'
        let s.=' '
        let bufnr=buflist[winnr-1]
        let file=bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        let m=''
        if getbufvar(bufnr, '&modified')
            let m='[+]'
        endif
        if buftype=='nofile'
            if file=~'\/.'
                let file=substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file=fnamemodify(file, ':p:t')
        endif
        if file==''
            let file='[No Name]'
        endif
        let s.=m
        let s.=i.':'
        let s.=file
        let s.='['.winnr.']'
        let s.=' '
        let i=i+1
    endwhile
    let s.='%T%#TabLineFill#%='
    let s.=(tabpagenr('$')>1 ? '%999XX' : 'X')
    return s
endfunction
" Set tabline colorscheme
if g:ivim_default_scheme=='gruvbox'
    let g:gruvbox_invert_tabline=1
endif
" Set up tab tooltips with each buffer name
set guitabtooltip=%F

" Set status line
if count(g:ivim_bundle_groups, 'ui')
    set laststatus=2 " Show the statusline
    set noshowmode " Hide the default mode text
    " Set status line colorscheme
    let g:airline_theme=tolower(g:ivim_default_scheme)
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.space = "\ua0"
    set ttimeoutlen=10

    let g:bufferline_echo=0
    let g:bufferline_modified='[+]'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'

    if g:ivim_fancy_font
        let g:airline_powerline_fonts=1
    else
        let g:airline_left_sep=''
        let g:airline_right_sep=''
    endif
endif

" Only have cursorline in current window and in normal window
augroup cursorline_group
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
augroup END

set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Use powerful wildmenu
set shortmess=at " Avoids hit enter
set showcmd " Show cmd

set backspace=indent,eol,start " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,] " Backspace and cursor keys wrap to
set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor

set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink

if g:ivim_show_number
    set number " Show line numbers
    " Toggle relativenumber
    nnoremap <Leader>n :set relativenumber!<CR>

    " setglobal relativenumber
    augroup relativenumber_group
        autocmd!
        autocmd WinEnter,FocusGained * :setlocal relativenumber
        autocmd WinLeave,FocusLost * :setlocal number
        autocmd InsertEnter * :setlocal number
        autocmd InsertLeave * :setlocal relativenumber
    augroup END

endif

set formatoptions+=rnlmM " Optimize format options
set wrap " Set wrap
set textwidth=80 " Change text width
if g:ivim_fancy_font
    set list " Show these tabs and spaces and so on
    set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ " Change listchars
    set linebreak " Wrap long lines at a blank
    set showbreak=↪  " Change wrap line break
    set fillchars=diff:⣿,vert:│ " Change fillchars
    augroup trailing " Only show trailing whitespace when not in insert mode
        autocmd!
        autocmd InsertEnter * :set listchars-=trail:⌴
        autocmd InsertLeave * :set listchars+=trail:⌴
    augroup END
endif

set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Colors and Fonts
"-------------------------------------------------

syntax on " Enable syntax
set synmaxcol=300
set lazyredraw
set background=dark " Set background
set t_Co=256 " Use 256 colors

" Load a colorscheme
if count(g:ivim_bundle_groups, 'ui')
    execute 'colorscheme '.g:ivim_default_scheme
else
    colorscheme desert
endif

" Set GUI font
if has('gui_running')
    if has('macunix')
        " set guifont=Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Mono:h14
        " set guifont=Sauce\ Code\ Pro\ Light\ Nerd\ Font\ Complete\ Mono:h12
        set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono:h12

        set macmeta
    else
        " set guifont=Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Mono\ 14
        " set guifont=Sauce\ Code\ Pro\ Light\ Nerd\ Font\ Complete\ Mono\ 12
        set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono\ 12
    endif
    set linespace=2
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Indent Related
"-------------------------------------------------

set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set expandtab " Convert all tabs typed to spaces
set tabstop=2
set softtabstop=2 " Indentation levels every four columns
set shiftwidth=2 " Indent/outdent by four columns
set shiftround " Indent/outdent to nearest tabstop

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Search Related
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set nohlsearch " Highlight search terms
set incsearch " Find as you type search
" set gdefault " turn on g flag

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
" cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Fold Related
"-------------------------------------------------

" Note: zi Invert 'foldenable'.
set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent> <Space> @=(foldlevel('.') ? 'za' : '\<Space>')<CR>
vnoremap <Space> zf

function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
set foldtext=MyFoldText()

set foldmethod=syntax
set nofoldenable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Key Mapping
"-------------------------------------------------

" avoid ESC
" inoremap jj <Esc>
" switching to jk
inoremap jk <Esc>

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Select entire buffer
nnoremap vaa ggvGg_

" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" Modify all the indents
nnoremap \= gg=G

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

" buffer explorer
nnoremap <leader>b :ls<cr>:b<space>

" new tab
nnoremap <silent> tt :tabnew<cr>
" nnoremap <leader>t :tabnew<cr>:Startify<cr>
nnoremap <silent> tx :tabclose<cr>

" split
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

set pastetoggle=<F10>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Plugin Setting
"--------------------------------------------------

" Setting for UI plugins
if count(g:ivim_bundle_groups, 'ui')

    " -> Startify
    let g:startify_session_dir=$HOME . '/.local/share/nvim/session'
    let g:startify_custom_header=[
                \'       _       _         ',
                \'      (_)   __(_)___ ___ ',
                \'     / / | / / / __ `__ \',
                \'    / /| |/ / / / / / / /',
                \'   /_/ |___/_/_/ /_/ /_/ ',
                \'                         ']
    let g:startify_custom_footer=['', '    This configuration is maintained by Zhang Guangda <zhangxiaoyu9350@gmail.com> and other contributors. Thanks!']
    if has('gui_running')
        hi StartifyHeader  guifg=#87afff
        hi StartifyFooter  guifg=#87afff
        hi StartifyBracket guifg=#585858
        hi StartifyNumber  guifg=#ffaf5f
        hi StartifyPath    guifg=#8a8a8a
        hi StartifySlash   guifg=#585858
    else
        hi StartifyHeader  ctermfg=111
        hi StartifyFooter  ctermfg=111
        hi StartifyBracket ctermfg=240
        hi StartifyNumber  ctermfg=215
        hi StartifyPath    ctermfg=245
        hi StartifySlash   ctermfg=240
    endif
    let g:startify_session_autoload       = 1
    let g:startify_session_persistence    = 1

    " -> Goyo & Limelight
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!

endif

" Setting for enhancement plugins
if count(g:ivim_bundle_groups, 'enhance')

    " -> delimitMate
    let delimitMate_expand_cr=1
    let delimitMate_expand_space=1
    let delimitMate_balance_matchpairs=1

    " -> Tcomment
    " Map \<Space> to commenting
    function! IsWhiteLine()
        if (getline('.')=~'^$')
            exe 'TCommentBlock'
            normal! j
        else
            normal! A
            exe 'TCommentRight'
            normal! l
            normal! x
        endif
        startinsert!
    endfunction
    nnoremap <silent> <LocalLeader><Space> :call IsWhiteLine()<CR">

    " allow maintain cursor after exit
    let g:multi_cursor_exit_from_insert_mode=0

    " -> Undo tree
    nnoremap <Leader>u :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle=1

    " -> Easy Align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

    " -> Splitjoin
    let g:splitjoin_split_mapping = ',s'
    let g:splitjoin_join_mapping  = ',j'
    let g:splitjoin_normalize_whitespace=1
    let g:splitjoin_align=1

    " -> EnhancedDiff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

    " shortcut for diffget
    map <silent> <leader>2 :diffget 2<CR>
    map <silent> <leader>3 :diffget 3<CR>
    map <silent> <leader>4 :diffget 4<CR>

    if has('macunix')
        set clipboard=unnamed
    else
        set clipboard=unnamedplus
    endif

    let g:golden_ratio_autocommand = 0
    nnoremap <silent> <Leader>g :GoldenRatioToggle<CR>

    nnoremap <silent> <Leader>0 :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>9 :exe "resize " . (winheight(0) * 2/3)<CR>
    nnoremap <silent> + :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
    nnoremap <silent> - :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

    " YankRing is really slow so comment it out for now
    " nnoremap <silent> <Leader>y :YRShow<CR>

    " Allow run macro in multi lines
    " https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

    function! ExecuteMacroOverVisualRange()
        echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
    endfunction

    " Add " to selected or word
    nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
    vnoremap <Leader>" <esc>a"<esc>`<i"<esc>`>ll

    " Add ' to selected or word
    nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel
    vnoremap <Leader>' <esc>a'<esc>`<i'<esc>`>ll
endif

" setting for moving plugins
if count(g:ivim_bundle_groups, 'move')

    let g:EasyMotion_do_mapping = 0 " Disable default mappings

    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    " nmap s <Plug>(easymotion-overwin-f)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap s <Plug>(easymotion-overwin-f2)

    " Turn on case insensitive feature
    let g:EasyMotion_smartcase = 1

    " Move to line
    " map <Leader>L <Plug>(easymotion-bd-jk)
    nmap <Leader>l <Plug>(easymotion-overwin-line)

    " Move to word
    " map  <Leader>w <Plug>(easymotion-bd-w)
    nmap <Leader>w <Plug>(easymotion-overwin-w)
endif

" Setting for navigation plugins
if count(g:ivim_bundle_groups, 'navigate')

    " -> NERD Tree
    nnoremap <Leader>d :NERDTreeToggle<CR>
    nnoremap <Leader>f :NERDTreeFind<CR>
    let NERDTreeChDirMode=2
    let NERDTreeShowBookmarks=1
    let NERDTreeShowHidden=1
    let NERDTreeShowLineNumbers=1
    augroup nerd_loader
        autocmd!
        autocmd VimEnter * silent! autocmd! FileExplorer
        autocmd BufEnter,BufNew *
                    \  if isdirectory(expand('<amatch>'))
                    \|   call plug#load('nerdtree')
                    \|   execute 'autocmd! nerd_loader'
                    \| endif
    augroup END

    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=**/bower_components/**,**/node_modules/**,**/tags
    let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|tmp|bower_components|coverage)|(\.(swp|ico|git|svn))$'
    let g:ctrlp_match_window = 'results:25' " overcome limit imposed by max height
    let g:ctrlp_max_files = 0
    let g:ctrlp_max_depth = 40

    if executable('rg')
        " Use rg over grep
        set grepprg=rg\ --vimgrep\ --no-heading
        set grepformat=%f:%l:%c:%m,%f:%l:%m

        let g:ackprg = 'rg --vimgrep --no-heading'

        cnoreabbrev Ack Ack!
        nnoremap <Leader>a :Ack!<Space>

        nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>

        " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
        " let g:ctrlp_working_path_mode = "ra"
        let g:ctrlp_working_path_mode = 0
    endif

endif

" Setting for completion plugins
if count(g:ivim_bundle_groups, 'complete')

    let g:deoplete#enable_at_startup = 1

    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--no-port-file"]

    inoremap <expr><tab> pumvisible() ? "\<C-N>" : "\<tab>"
    inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

    function! JumpDefinition()
        if &filetype == "javascript"
            execute 'TernDef'
        elseif &filetype == "javascript.jsx"
            execute 'TernDef'
        elseif &filetype == "typescript"
            execute 'TSDef'
        endif
    endfunction
    nnoremap <leader>jd :call JumpDefinition()<CR>

    " Setting info for snips
    let g:snips_author=g:ivim_user
    let g:snips_email=g:ivim_email
    let g:snips_github=g:ivim_github

    " rust
    let g:deoplete#sources#rust#racer_binary=$HOME.'/.cargo/bin/racer'
    let g:deoplete#sources#rust#rust_source_path=$HOME.'/opensource/rust/src'
    " let g:deoplete#sources#rust#show_duplicates=1
    " let g:deoplete#sources#rust#disable_keymap=1
    " let g:deoplete#sources#rust#documentation_max_height=20

    " typescript
    " K              :TSDoc
    " <leader>tdp    :TSDefPreview
    " <c-]>          :TSTypeDef
    " <leader>jd     :TSDef
    let g:nvim_typescript#default_mappings = 1
    nnoremap <leader>ti :TSImport<CR>
    nnoremap <leader>jds :TSDefPreview<CR>
endif

" Setting for compiling plugins
if count(g:ivim_bundle_groups, 'compile')
    " vim-jsx
    let g:jsx_ext_required = 1

    " -> Ale
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '∆'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'typescript': ['tslint', 'tsserver']
    \}

    let g:ale_fixers = {}
    let g:ale_fixers['javascript'] = ['prettier', 'eslint']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_fixers['typescript'] = ['prettier', 'tslint']
    let g:ale_fixers['elixir'] = ['mix_format']
    let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
    let g:ale_javascript_prettier_use_local_config = 1

    nnoremap <Leader>p :ALEFix<CR>

    augroup prettier_group
        autocmd!
        autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ babel
        autocmd FileType json setlocal formatprg=prettier\ --stdin\ --parser\ json
        autocmd FileType typescript setlocal formatprg=prettier\ --stdin\ --parser\ typescript
        autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
        " prettier on save
        " autocmd BufWritePre *.js :normal gggqG
    augroup END

    " -> Singlecompile
    " Singlecompile is really slow, so comment it out for now
    " nnoremap <Leader>r :SingleCompileRun<CR>
    " nnoremap <Leader>B :SingleCompile<CR>
    " let g:SingleCompile_showquickfixiferror=1

    " call SingleCompile#SetCompilerTemplate('markdown', 'pandoc',
    "             \ 'Discount Markdown Processor for Pandoc', 'pandoc',
    "             \ '-f markdown_github $(FILE_NAME)$ >$(FILE_TITLE)$.html',
    "             \ SingleCompile#GetDefaultOpenCommand() .
    "             \ ' "$(FILE_TITLE)$.html"')
    " call SingleCompile#ChooseCompiler('markdown', 'pandoc')

    function! LebabFunc(transform)
        execute "!lebab --transform=" . a:transform . " % -o %"
    endfunction
    command! -nargs=1 LebabWithParam call LebabFunc(<f-args>)

    command! Lebab :!lebab --transform='arrow,for-of,for-each,arg-rest,arg-spread,obj-method,obj-shorthand,no-strict,exponent,multi-var' % -o %
    command! LebabUnsafe :!lebab --transform='let,class,commonjs,template,default-param,destruct-param,includes' % -o %

endif

" Setting for git plugins
if count(g:ivim_bundle_groups, 'git')
    set updatetime=1000
endif

" Setting for language specificity
if count(g:ivim_bundle_groups, 'language')

    " -> Emmet
    let g:user_emmet_leader_key='<C-E>'
    let g:user_emmet_settings={'indentation':'    '}
    let g:use_emmet_complete_tag=1

    " -> jsdoc.vim
    nmap <silent> <C-m> <Plug>(jsdoc)
    let g:jsdoc_enable_es6=1
    let g:jsdoc_param_description_separator='-'

    " -> javascript.vim
    let g:javascript_plugin_jsdoc = 1

endif

"--------------------------------------------------
" => Project Setting
"--------------------------------------------------

" User nerd tree
let g:project_enable_welcome=0
let g:project_use_nerdtree = 1

set rtp+=~/.local/share/nvim/plugged/vim-project/

" config of project files should go to local.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Local Setting
"--------------------------------------------------

" Use local vimrc if available
if filereadable(expand($HOME . '/.config/nvim/local.vim'))
    source $HOME/.config/nvim/local.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: set sw=4 sts=4 et fdm=marker:
