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
" => ivim Setting {{{
"------------------------------------------------

" ivim user setting
let g:ivim_user='Guangda Zhang' " User name
let g:ivim_email='zhangxiaoyu9350@gmail.com' " User email
let g:ivim_github='https://github.com/inkless' " User github

" ivim color settings (OceanNext, PaperColor, hybrid, gruvbox or tender)
let g:ivim_default_scheme='gruvbox'
" ivim ui setting
let g:ivim_fancy_font=1 " Enable using fancy font{{{}}}
let g:ivim_show_number=1 " Enable showing number
let g:ivim_use_relative_number=0 " Use relative number
" let g:ivim_autocomplete='YCM'
" ivim plugin setting
let g:ivim_bundle_groups=['ui', 'enhance', 'move', 'navigate',
            \'complete', 'compile', 'git', 'language']
let g:ivim_enable_lsp=1 " Enable Language Server
let g:ivim_ale_completion_enabled=0 " Enable ALE LSP

" Customise ivim settings for personal usage
if filereadable(expand($HOME . '/.config/nvim/local.ivim.vim'))
    source $HOME/.config/nvim/local.ivim.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"------------------------------------------------
" => General {{{
"------------------------------------------------

" nvim
if has('macunix')
    set termguicolors
endif

set guicursor=

set nocompatible " Get out of vi compatible mode

filetype plugin indent on " Enable filetype
let mapleader=',' " Change the mapleader
let maplocalleader='\' " Change the maplocalleader
set timeoutlen=500 " Time to wait for a command

" Source the vimrc file after saving it
augroup vim_source
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>
nnoremap Q <Nop>

set autoread " Set autoread when a file is changed outside
set autowrite " Write on make/shell commands
set hidden " Turn on hidden"

set history=1000 " Increase the lines of history
set modeline " Turn on modeline
set encoding=utf-8 " Set utf-8 encoding

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
  autocmd! GUIEnter * set visualbell t_vb=
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => Platform Specific Setting {{{
"-------------------------------------------------
set viewoptions+=slash,unix " Better Unix/Windows compatibility
set viewoptions-=options " in case of mapping change

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"--------------------------------------------------
" => Vim-Plug {{{
"--------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd! VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" UI Setting {{{
if count(g:ivim_bundle_groups, 'ui') " UI setting
    " Plug 'w0ng/vim-hybrid' " Colorscheme hybrid
    Plug 'morhetz/gruvbox' " Colorscheme gruvbox
    " Plug 'joshdick/onedark.vim'
    " Plug 'NLKNguyen/papercolor-theme'
    " Plug 'mhartington/oceanic-next'
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' " Status line
    Plug 'ryanoasis/vim-devicons' " Devicons
    Plug 'mhinz/vim-startify' " Start page
endif
" }}}

" Vim enhance {{{
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
    Plug 'Shougo/echodoc.vim'
endif
" }}}

" Moving {{{
if count(g:ivim_bundle_groups, 'move') " Moving
    Plug 'tpope/vim-unimpaired' " Pairs of mappings
    Plug 'Lokaltog/vim-easymotion' " Easy motion
    Plug 'unblevable/quick-scope' " Quick scope
    Plug 'christoomey/vim-tmux-navigator' " Tmux navigation
endif
" }}}

" Navigation {{{
if count(g:ivim_bundle_groups, 'navigate') " Navigation
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " NERD tree
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } " NERD tree git plugin
    " Plug 'junegunn/fzf' " fzf
    if has('macunix')
      Plug '/usr/local/opt/fzf' " fzf is installed through homebrew
    else
      Plug '~/.fzf' " in linux I have to put fzf here, so I need a soft link in mac
    endif
    Plug 'junegunn/fzf.vim' " fzf
    Plug 'mileszs/ack.vim' " ack
endif
" }}}

" Completion {{{
if count(g:ivim_bundle_groups, 'complete') " Completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/jsonc.vim'
    Plug 'honza/vim-snippets'
endif
" }}}

" Compiling/Linting {{{
if count(g:ivim_bundle_groups, 'compile') " Compiling
    Plug 'w0rp/ale' " Async syntax checking
    " Plug 'xuhdev/SingleCompile' " Single compile
    Plug 'JamshedVesuna/vim-markdown-preview' " markdown preview
    Plug 'inkless/vim-test' " run test
endif
" }}}

" Git {{{
if count(g:ivim_bundle_groups, 'git') " Git
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'tpope/vim-rhubarb' " Github extension for vim fugitive
    Plug 'gregsexton/gitv' " Gitk clone
    if has('signs')
        Plug 'airblade/vim-gitgutter' " Git diff sign
    endif
endif
" }}}

" Language {{{
if count(g:ivim_bundle_groups, 'language') " Language Specificity
    Plug 'editorconfig/editorconfig-vim'
    Plug 'sheerun/vim-polyglot' " Language Support (includes javascript and all other types)

    " Language specific enhancement/completion etc.
    Plug 'pedrohdz/vim-yaml-folds'
    Plug 'mattn/emmet-vim' " Emmet
    Plug 'heavenshell/vim-jsdoc' " JSDoc for vim
    Plug 'greyblake/vim-preview' " vim preview
    Plug 'slashmili/alchemist.vim'
    Plug 'tmhedberg/SimpylFold' " python folding
    " Plug 'sukima/vim-ember-imports'
    " Plug 'AndrewRadev/ember_tools.vim'
    " Plug 'davidhalter/jedi-vim', { 'for': 'python' } " Python jedi plugin
    " Plug 'tpope/vim-rails' " Rails
    " Plug 'tpope/vim-bundler' " gem bundler
endif
" }}}

if filereadable(expand($HOME . '/.config/nvim/local.bundles.vim')) " Load local bundles
    source $HOME/.config/nvim/local.bundles.vim
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => User Interface {{{
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

    if g:ivim_use_relative_number
      " setglobal relativenumber
      augroup relativenumber_group
        autocmd!
        autocmd WinEnter,FocusGained * :setlocal relativenumber
        autocmd WinLeave,FocusLost * :setlocal number
        autocmd InsertEnter * :setlocal number
        autocmd InsertLeave * :setlocal relativenumber
      augroup END
    endif
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
" }}}

"-------------------------------------------------
" => Colors and Fonts {{{
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
" }}}

"-------------------------------------------------
" => Indent Related {{{
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
" }}}

"-------------------------------------------------
" => Fold Related {{{
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
" }}}

"-------------------------------------------------
" => Key Mapping {{{
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
nnoremap vaa ggVG

" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" Modify all the indents
nnoremap \= gg=G

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

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

" Move line up/down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Add "/' to selected or word
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel

" Add ' to selected or word
" for [left_c, right_c] in items({ '''': '''', '"': '"', '(': ')', '{': '}', '[': ']' })
for [left_c, right_c] in items({ '(': ')', '{': '}', '[': ']' })
    execute 'vnoremap ' . left_c . ' <esc>a' . right_c . '<esc>`<i' . left_c . '<esc>`>ll'
endfor

nnoremap  <Leader>e :e!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"--------------------------------------------------
" => Plugin Setting {{{
"--------------------------------------------------

" Setting for UI plugins {{{
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

endif
" }}}

" Setting for enhancement plugins {{{
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
    nnoremap <silent> <Leader>gr :GoldenRatioToggle<CR>

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

    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'signature'

    " Quickfix Mappings
    " nnoremap <Leader>c :copen<CR>
    augroup quickfix_mapping
        autocmd!
        autocmd FileType qf nnoremap <buffer> q :cclose<CR>
        autocmd FileType qf nnoremap <buffer> o :execute "cc " . line(".")<CR>
        autocmd FileType qf nnoremap <buffer> <CR> :execute "cc " . line(".")<CR>
    augroup END
endif
" }}}

" setting for moving plugins {{{
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
" }}}

" Setting for navigation plugins {{{
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

    if executable('rg')
        " Use rg over grep
        set grepprg=rg\ --vimgrep\ --no-heading
        set grepformat=%f:%l:%c:%m,%f:%l:%m

        let g:ackprg = 'rg --vimgrep --no-heading'

        cnoreabbrev Ack Ack!
        nnoremap <Leader>a :Ack!<Space>
        nnoremap <Leader>rg :Rg<CR>
        nnoremap <Leader>b :Buffers<CR>

        nnoremap S :Ack! -F "<C-R><C-W>"<CR>

        " Search file Ctrl-P
        nnoremap <c-p> :Files<CR>
        " Recent files
        nnoremap <c-e> :History<CR>
    endif

endif
" }}}

" Setting for completion plugins {{{
if count(g:ivim_bundle_groups, 'complete')
    " This will show the popup menu even if there's only one match (menuone),
    " prevent automatic selection (noselect) and prevent automatic text injection
    " into the current line (noinsert).
    " set completeopt=noinsert,menuone,noselect
    set completeopt+=longest
    set completeopt-=preview

    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300

    " suppress the annoying 'match x of y', 'The only match' and 'Pattern not
    " found' messages
    set shortmess+=c

    " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
    inoremap <C-c> <ESC>

    " Use <TAB> to select the popup menu:
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    if g:ivim_enable_lsp

        " To be able to actually use coc, we need to install following extensions
        " :CocInstall coc-tsserver
        " :CocInstall coc-snippets
        " :CocInstall coc-solargraph
        " :CocInstall coc-rls
        " :CocInstall coc-python
        " :CocInstall coc-json
        " :CocInstall coc-html
        " :CocInstall coc-css

        " Use `[d` and `]d` for navigate diagnostics
        nmap <silent> [d <Plug>(coc-diagnostic-prev)
        nmap <silent> ]d <Plug>(coc-diagnostic-next)

        nmap <silent> <c-]> <Plug>(coc-definition)
        nmap <silent> <c-w><c-]> :call CocAction('jumpDefinition', 'tab drop')<CR>
        nmap <silent> gy <Plug>(coc-type-definition)
        " nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> K :call <SID>show_documentation()<CR>
        nmap <silent> <F7> <Plug>(coc-references)
        nmap <silent> gr <Plug>(coc-references)
        nmap <silent> gR <Plug>(coc-rename)
        nmap <silent> <Leader>gf <Plug>(coc-format-selected)
        vmap <silent> <Leader>gf <Plug>(coc-format-selected)

        " Using CocList
        nnoremap <silent> <Leader>c :<C-u>CocList<cr>
        nnoremap <silent> <Leader>cc :<C-u>CocList commands<cr>
        nnoremap <silent> <Leader>ca <Plug>(coc-codeaction)

        " Show all diagnostics
        nnoremap <silent> ga  :<C-u>CocList diagnostics<CR>
        " Find symbol of current document
        nnoremap <silent> go  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> gS  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> gj  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> gk  :<C-u>CocPrev<CR>
        " Resume latest coc list
        nnoremap <silent> gp  :<C-u>CocListResume<CR>

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')

        function! s:show_documentation()
            if &filetype == 'vim'
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Use <c-space> for trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        set signcolumn=yes

        " Better display for messages
        " set cmdheight=2

        augroup coc_group
            autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json,javascript,javascript.jsx setl formatexpr=CocAction('formatSelected')
            autocmd BufNewFile,BufRead coc-settings.json,tsconfig.json setlocal filetype=jsonc
            " Update signature help on jump placeholder
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        let g:coc_snippet_next = '<TAB>'
        let g:coc_snippet_prev = '<S-TAB>'
    endif

    " Setting info for snips
    let g:snips_author=g:ivim_user
    let g:snips_email=g:ivim_email
    let g:snips_github=g:ivim_github
endif
" }}}

" Setting for compiling plugins {{{
if count(g:ivim_bundle_groups, 'compile')
    " -> Ale
    let g:ale_fix_on_save = 1
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '∆'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    " disable python linting, it's done in coc-python
    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'javascriptreact': ['eslint'],
    \   'typescript': ['eslint'],
    \   'typescriptreact': ['eslint'],
    \   'ruby': ['rubocop'],
    \   'python': ['flake8', 'mypy']
    \}

    let g:ale_fixers = {}
    let g:ale_fixers['html'] = ['prettier']
    let g:ale_fixers['javascript'] = ['eslint']
    let g:ale_fixers['javascriptreact'] = ['eslint']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_fixers['typescript'] = ['eslint']
    let g:ale_fixers['typescriptreact'] = ['eslint']
    let g:ale_fixers['elixir'] = ['mix_format']
    let g:ale_fixers['ruby'] = ['trim_whitespace', 'rubocop']
    let g:ale_fixers['python'] = ['black', 'autopep8']

    let g:ale_javascript_prettier_use_local_config = 1

    nnoremap <silent> [a :ALEPrevious<CR>
    nnoremap <silent> ]a :ALENext<CR>

    " Ale completion
    function! EnableAleCompletion()
        let g:ale_sign_column_always = 1
        let g:ale_linters['javascript'] = ['eslint', 'tsserver']
        let g:ale_linters['typescript'] = ['eslint', 'tsserver']
        let g:ale_linters['ruby'] = ['rubocop', 'solargraph']
    endfunction

    if g:ivim_ale_completion_enabled
        let g:ale_completion_enabled=1

        nnoremap <silent> <c-]> :ALEGoToDefinition<CR>
        nnoremap <silent> <c-w><c-]> :ALEGoToDefinitionInVSplit<CR>
        nnoremap <silent> K :ALEHover<CR>
        nnoremap <silent> <F7> :ALEFindReferences<CR>
        " only for typescript
        nnoremap <Leader>ld :ALEDocumentation<CR>
        nnoremap <Leader>ls :ALESymbolSearch<Space>

        augroup ale_completion_group
            autocmd!
            autocmd BufEnter *.js,*.jsx,*.ts,*.tsx call EnableAleCompletion()
            autocmd BufEnter *.rb call EnableAleCompletion()
            " sometimes *.d.ts will go to ~/Library/Caches/**/*.d.ts, which would be
            " super slow, disable it to save time
            autocmd BufNewFile,BufRead *.d.ts let b:ale_linters={'typescript': []}
        augroup END
    endif

    nnoremap <Leader>p :ALEFix<CR>

    augroup prettier_group
        autocmd!
        autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
        " autocmd BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx " \| setlocal formatprg=prettier\ --stdin\ --parser\ babel
        " autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.jsx " \| setlocal formatprg=prettier\ --stdin\ --parser\ typescript
        " autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ babel
        " autocmd FileType json setlocal formatprg=prettier\ --stdin\ --parser\ json
        " autocmd FileType typescript setlocal formatprg=prettier\ --stdin\ --parser\ typescript
        " prettier on save
        " autocmd BufWritePre *.js :normal gggqG
    augroup END

    function! LebabFunc(transform)
        execute "!lebab --transform=" . a:transform . " % -o %"
    endfunction
    command! -nargs=1 LebabWithParam call LebabFunc(<f-args>)

    command! Lebab :!lebab --transform='arrow,for-of,for-each,arg-rest,arg-spread,obj-method,obj-shorthand,no-strict,exponent,multi-var' % -o %
    command! LebabUnsafe :!lebab --transform='let,class,commonjs,template,default-param,destruct-param,includes' % -o %


    " markdown preview
    let vim_markdown_preview_hotkey='<C-m>'
    let vim_markdown_preview_github=1
    if has('macunix')
        let vim_markdown_preview_browser='Google Chrome'
    endif

    " vim-test
    " make test commands execute using dispatch.vim
    let test#strategy = "vimux"
    function! DebugNearestFunc()
      let g:test#javascript#jest#executable = 'node --inspect-brk node_modules/.bin/jest'
      TestNearest
      unlet g:test#javascript#jest#executable
    endfunction
    command! DebugNearest :call DebugNearestFunc()

    function! DebugFileFunc()
      let g:test#javascript#jest#executable = 'node --inspect-brk node_modules/.bin/jest'
      TestFile
      unlet g:test#javascript#jest#executable
    endfunction
    command! DebugFile :call DebugFileFunc()

    function! DebugFileWatchFunc()
      let g:test#javascript#jest#executable = 'node --inspect-brk node_modules/.bin/jest --runInBand --no-cache --watch'
      TestFile
      unlet g:test#javascript#jest#executable
    endfunction
    command! DebugFileWatch :call DebugFileWatchFunc()

    function! TestFileWatchFunc()
      let g:test#javascript#jest#executable = 'node node_modules/.bin/jest --runInBand --watch'
      TestFile
      unlet g:test#javascript#jest#executable
    endfunction
    command! TestFileWatch :call TestFileWatchFunc()

    nnoremap <silent> t<C-n> :TestNearest<CR>
    nnoremap <silent> t<C-f> :TestFile<CR>
    nnoremap <silent> t<C-s> :TestSuite<CR>
    nnoremap <silent> t<C-l> :TestLast<CR>
    nnoremap <silent> t<C-d> :DebugFileWatch<CR>
    nnoremap <silent> t<C-w> :TestFileWatch<CR>
endif
" }}}

" Setting for git plugins {{{
if count(g:ivim_bundle_groups, 'git')
    set updatetime=1000
endif
" }}}

" Setting for language specificity {{{
if count(g:ivim_bundle_groups, 'language')
    " vim jsx colorful
    let g:vim_jsx_pretty_colorful_config = 1

    " -> Emmet
    let g:user_emmet_leader_key='<c-y>'
    let g:user_emmet_settings={'indentation':'  '}
    let g:use_emmet_complete_tag=1

    " -> jsdoc.vim
    nmap <silent> <C-m> <Plug>(jsdoc)
    let g:jsdoc_enable_es6=1
    let g:jsdoc_param_description_separator='-'

    " -> javascript.vim
    let g:javascript_plugin_jsdoc = 1

    " -> SimplyFold
    let g:SimpylFold_docstring_preview = 1


endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"--------------------------------------------------
" => Project Setting {{{
"--------------------------------------------------

" User nerd tree
let g:project_enable_welcome=0
let g:project_use_nerdtree = 1

set rtp+=~/.local/share/nvim/plugged/vim-project/

" config of project files should go to local.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"--------------------------------------------------
" => Local Setting {{{
"--------------------------------------------------

" Use local vimrc if available
if filereadable(expand($HOME . '/.config/nvim/local.vim'))
    source $HOME/.config/nvim/local.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

" vim: set sw=4 sts=4 et fdm=marker fen:
