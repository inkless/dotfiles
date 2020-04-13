let g:ale_linters['markdown'] = ['markdownlint']

function! NoBackUp(tile) abort
  setlocal nobackup
  setlocal nowritebackup
endfunction

function! SetPythonRunner(tile) abort
  let g:test#python#runner = "nose"
  let g:test#python#nose#executable = 'nosetests -s'
endfunction

function! SetTslint(tile) abort
  let g:ale_linters['typescript'] = ['tslint']
  let g:ale_fixers['typescript'] = ['prettier', 'tslint']
endfunction

" ali-client
call project#rc("~/workspace")
Project     'all-the-things'
Callback    'all-the-things'                    , ['SetPythonRunner']
Project     'salt'

call project#rc("~/workspace/web-ux")
Project     'axp'
" Callback    'axp'                               , ['NoBackUp']
Project     'pricing'
" Callback    'pricing'                           , ['NoBackUp']

" keevo
call project#rc("~/workspace/keevo")
Project     'desktop-app'
Callback    'desktop-app'                       , ['NoBackUp']

Project     'keevo-cli'
Callback    'keevo-cli'                         , ['NoBackUp']

Project     'u2f-host-node'
Callback    'u2f-host-node'                     , ['NoBackUp']

" others
call project#rc("~/workspace")
Project     'react-starter-kit'
Callback    'react-starter-kit'                 , ['NoBackUp']

Project     '~/dotfiles'                        , 'dotfiles'

" we are not using vim-project's welcome page
" so we have to define in Startify again
let g:startify_bookmarks=[
\'~/workspace/all-the-things',
\'~/workspace/web-ux/axp',
\'~/workspace/keevo/desktop-app',
\'~/workspace/keevo/keevo-cli',
\'~/workspace/keevo/u2f-host-node',
\'~/workspace/react-starter-kit',
\'~/dotfiles',
\]

" augroup ali_abbrev
"   autocmd!
"   autocmd FileType gitcommit inoreabbrev <buffer> jira: https://prosperworks.atlassian.net/browse/ALI-
" augroup END
