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
let mapleader=' ' " Change the mapleader
let maplocalleader=',' " Change the maplocalleader

filetype plugin indent on " Enable filetype
set termguicolors
set timeoutlen=500 " Time to wait for a command
set undofile
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=**/bower_components/**,**/node_modules/**,**/tags

" Source the vimrc file after saving it
augroup vim_source
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

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
Plug 'morhetz/gruvbox' " Colorscheme gruvbox
" Plug 'joshdick/onedark.vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' " Status line
Plug 'ryanoasis/vim-devicons' " Devicons
Plug 'mhinz/vim-startify' " Start page
" }}}

" Vim enhance {{{
Plug 'Raimondi/delimitMate' " Closing of quotes
Plug 'tomtom/tcomment_vim' " Commenter
Plug 'tpope/vim-repeat' " Repeat
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Undo tree
Plug 'tpope/vim-surround' " Surround
Plug 'AndrewRadev/splitjoin.vim' " Splitjoin
Plug 'sickill/vim-pasta' " Vim pasta
Plug 'chrisbra/vim-diff-enhanced' " Create better diffs
Plug 'mhinz/vim-hugefile' " Largefile
" Plug 'vim-scripts/YankRing.vim' "yank history for vim
Plug 'amiorin/vim-project' " Project
Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'scss', 'vim'] } " hmm
Plug 'KabbAmine/vCoolor.vim' " Color Picker
Plug 'godlygeek/tabular' " Vim script for text filtering and alignment
Plug 'benmills/vimux' " Vim plugin to interact with tmux
Plug 'junegunn/vim-easy-align'
" }}}

" Moving {{{
Plug 'tpope/vim-unimpaired' " Pairs of mappings
Plug 'Lokaltog/vim-easymotion' " Easy motion
Plug 'unblevable/quick-scope' " Quick scope
Plug 'christoomey/vim-tmux-navigator' " Tmux navigation
" }}}

" Navigation {{{
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " NERD tree
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } " NERD tree git plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " fzf
" }}}

" Completion {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'
Plug 'honza/vim-snippets'
Plug 'github/copilot.vim'
" }}}

" Compiling/Linting {{{
" Plug 'w0rp/ale' " Async syntax checking
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'inkless/vim-test' " run test
" }}}

" Git {{{
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-rhubarb' " Github extension for vim fugitive
Plug 'gregsexton/gitv' " Gitk clone
if has('signs')
  Plug 'airblade/vim-gitgutter' " Git diff sign
endif
" }}}

" Language {{{
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot' " Language Support (includes javascript and all other types)

" Language specific enhancement/completion etc.
Plug 'pedrohdz/vim-yaml-folds'
Plug 'mattn/emmet-vim' " Emmet
Plug 'heavenshell/vim-jsdoc', {
      \ 'for': ['javascript', 'javascript.jsx','typescript', 'typescript.tsx'],
      \ 'do': 'make install'
      \}
Plug 'slashmili/alchemist.vim'
Plug 'tmhedberg/SimpylFold' " python folding
" }}}

" which-key.nvim
" this cannot be wrapped inside if
set rtp+=~/.local/share/nvim/plugged/which-key.nvim/
Plug 'folke/which-key.nvim'
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

if filereadable(expand($HOME . '/.config/nvim/local.bundles.vim')) " Load local bundles
    source $HOME/.config/nvim/local.bundles.vim
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => User Interface {{{
"-------------------------------------------------
" Set tabline colorscheme
if g:ivim_default_scheme=='gruvbox'
    let g:gruvbox_invert_tabline=1
endif

" Set status line colorscheme
let g:airline_theme=tolower(g:ivim_default_scheme)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts=1

" Only have cursorline in current window and in normal window
augroup cursorline_group
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
augroup END

" set wildmenu " Show list instead of just completing
" set wildmode=list:longest,full " Use powerful wildmenu
" set shortmess=at " Avoids hit enter

set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor

nnoremap <Leader>n :set relativenumber!<CR>

" set formatoptions+=rnlmM " Optimize format options
" set textwidth=80 " Change text width

set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => Colors and Fonts {{{
"-------------------------------------------------

" Load a colorscheme
execute 'colorscheme '.g:ivim_default_scheme

function! ChangeBackground()
  try
    if readfile(glob('~/.term-theme'))[0] == 'dark'
      set background=dark   " for the dark version of the theme
    else
      set background=light  " for the light version of the theme
    endif
    execute "AirlineRefresh"
  catch
  endtry
endfunction

" initialize the colorscheme for the first run
call ChangeBackground()

autocmd Signal SIGUSR1 call ChangeBackground()

" Set GUI font
if has('macunix')
    " set guifont=Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Mono:h14
    " set guifont=Sauce\ Code\ Pro\ Light\ Nerd\ Font\ Complete\ Mono:h12
    set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono:h12
else
    " set guifont=Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Mono\ 14
    " set guifont=Sauce\ Code\ Pro\ Light\ Nerd\ Font\ Complete\ Mono\ 12
    set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono\ 12
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => Indent Related {{{
"-------------------------------------------------

set smartindent
set expandtab " Convert all tabs typed to spaces
set tabstop=2
set softtabstop=2 " Indentation levels every 2 columns
set shiftround " Indent/outdent to nearest tabstop

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => Search Related {{{
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set nohlsearch " Highlight search terms

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
nnoremap <Leader>hl :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => Fold Related {{{
"-------------------------------------------------

" Note: zi Invert 'foldenable'.
set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent> <CR> @=(foldlevel('.') ? 'za' : '<C-v><CR>')<CR>
vnoremap <F9> zf

set foldmethod=syntax
set nofoldenable " no fold by default

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"-------------------------------------------------
" => Key Mapping {{{
"-------------------------------------------------

" avoid ESC
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

" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

" new tab
nnoremap <Leader><Tab>n :tabnew<cr>
nnoremap <Leader><Tab>x :tabclose<cr>

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

nnoremap <Leader>br :e!<CR>
nnoremap <Leader>b] :bnext<CR>
nnoremap <Leader>b[ :bprevious<CR>
nnoremap <A-n> :bnext<CR>:redraw<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <C-c> <ESC>

nnoremap <Leader>` <C-^>
nnoremap <c-q> :q!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

"--------------------------------------------------
" => Plugin Setting {{{
"--------------------------------------------------

" Setting for UI plugins {{{
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

" }}}

" Setting for enhancement plugins {{{

" -> delimitMate
let delimitMate_expand_cr=1
let delimitMate_expand_space=1
let delimitMate_balance_matchpairs=1

" -> Tcomment
" <c-/><c-/> :: :TComment
" <c-/>b     :: :TCommentBlock
" <c-/>i     :: :TCommentInline
" <c-_>r     :: :TCommentRight
" <c-_>p     :: Comment the current inner paragraph

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
map <silent> <leader>d2 :diffget 2<CR>
map <silent> <leader>d3 :diffget 3<CR>
map <silent> <leader>d4 :diffget 4<CR>

if has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

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

" Quickfix Mappings
" nnoremap <Leader>c :copen<CR>
augroup quickfix_mapping
    autocmd!
    autocmd FileType qf nnoremap <buffer> q :cclose<CR>
    autocmd FileType qf nnoremap <buffer> o :execute "cc " . line(".")<CR>
    autocmd FileType qf nnoremap <buffer> <CR> :execute "cc " . line(".")<CR>
augroup END

" Surround
" Add " to a word
" vwS"
" ysiw"

" }}}

" setting for moving plugins {{{

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
" }}}

" Setting for navigation plugins {{{

" -> NERD Tree {{{
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>o :NERDTreeFind<CR>

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
" }}}

" fzf.vim {{{
nnoremap <Leader>, :Buffers<CR>
nnoremap <Leader><Space> :Files<CR>
" Recent files
nnoremap <Leader>fr :History<CR>
nnoremap <Leader>f: :History:<CR>
nnoremap <Leader>f/ :History/<CR>
nnoremap <Leader>fc :Commands<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>fa :Marks<CR>
nnoremap <Leader>fh :Helptags<CR>

if executable('rg')
    nnoremap <Leader>/ :Rg<CR>
    nnoremap S :Rg <C-R><C-W><CR>
endif
" }}}
" }}}

" Setting for completion plugins {{{
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
" set completeopt=noinsert,menuone,noselect
" set completeopt+=longest
" set completeopt-=preview

" coc settings {{{
" To be able to actually use coc, we need to install following extensions
" :CocInstall coc-tsserver
" :CocInstall coc-eslint
" :CocInstall coc-snippets
" :CocInstall coc-solargraph
" :CocInstall coc-rust-analyzer
" :CocInstall coc-pyright
" :CocInstall coc-json
" :CocInstall coc-html
" :CocInstall coc-css
" :CocInstall coc-lua

" Some servers have issues with backup files, see https://github.com/neoclide/coc.nvim/issues/649
" set nobackup
" set nowritebackup

" Better display for messages
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[d` and `]d` for navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <c-w><c-]> :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gD <Plug>(coc-references)

nmap <silent> <Leader>cf <Plug>(coc-format-selected)
vmap <silent> <Leader>cf <Plug>(coc-format-selected)
nmap <silent> <Leader>cr <Plug>(coc-rename)
nmap <silent> gR <Plug>(coc-rename)

nmap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Using CocList
nnoremap <Leader>a <Plug>(coc-codeaction)
nnoremap <Leader>C :<C-u>CocList<cr>
" Apply AutoFix to problem on the current line.
nnoremap <Leader>cq <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
nnoremap <Leader>cl <Plug>(coc-codelens-action)

" Show all diagnostics
nnoremap <silent><nowait> <Leader>ca :<C-u>CocList diagnostics<CR>
" Manage extensions.
nnoremap <silent><nowait> <Leader>ce :<C-u>CocList extensions<cr>
" Show coclist commands
nnoremap <silent><nowait> <Leader>cc :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <Leader>co :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <Leader>cs :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <Leader>cj :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <Leader>ck :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <Leader>cp :<C-u>CocListResume<CR>

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Notice: this does work well in tmux, but annoying since <c-b> is tmux prefix
" nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup coc_group
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,javascript,javascript.jsx setl formatexpr=CocAction('formatSelected')
  autocmd BufNewFile,BufRead coc-settings.json,tsconfig.json setlocal filetype=jsonc
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" let g:coc_snippet_next = '<TAB>'
" let g:coc_snippet_prev = '<S-TAB>'
"
" }}}

" Setting info for snips {{{
let g:snips_author=g:ivim_user
let g:snips_email=g:ivim_email
let g:snips_github=g:ivim_github
" }}}

" }}}

" Setting for compiling plugins {{{

augroup prettier_group
    autocmd!
    autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
augroup END

" vim-test {{{
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

nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>td :DebugFileWatch<CR>
nnoremap <Leader>tw :TestFileWatch<CR>

" }}}

" Markdown
nnoremap <Leader>m <Plug>MarkdownPreviewToggle
" }}}

" Setting for git plugins {{{
" set updatetime=1000

nnoremap <Leader>go :Git checkout %<CR>
nnoremap <Leader>gl :Git blame<CR>
nnoremap <Leader>gj :GitGutterNextHunk<CR>
nnoremap <Leader>gk :GitGutterPrevHunk<CR>
nnoremap <Leader>gs :GitGutterStageHunk<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>
nnoremap <Leader>gd :GitGutterDiffOrig<CR>
" }}}

" Setting for language specificity {{{

" -> Emmet
let g:user_emmet_leader_key='<c-y>'
let g:user_emmet_settings={'indentation':'  '}
let g:use_emmet_complete_tag=1

" -> vim-doge
" let g:doge_mapping='<LocalLeader>d'

" -> jsdoc.vim
nmap <silent> <LocalLeader>d <Plug>(jsdoc)

" -> SimpylFold
let g:SimpylFold_docstring_preview = 1

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
