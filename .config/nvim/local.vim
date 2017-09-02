" local project
call project#rc("~/playground")
Project     'npm_test'
Project     'ember-app'

" Some github projects
call project#rc("~/projects")
Project     'broccoli-asset-rewrite'
Project     'froala_editor_sources_2.4.2'
Project     'ember.js'

Project     '~/scripts'                         , 'scripts'
Project     '~/dotfiles'                        , 'dotfiles'
Project     '~/ivim'                            , 'ivim'

Project     '~/dev-getting-started'             , 'dev-getting-started'
Project     '~/clientbox'                       , 'clientbox'

" we are not using vim-project's welcome page
" so we have to define in Startify again
let g:startify_bookmarks=[
\'~/ali',
\'~/ali/client',
\'~/clientbox',
\'~/dev-getting-started',
\'~/dotfiles',
\'~/scripts',
\'~/playground/ember-app',
\'~/playground/npm_test',
\'~/projects/ember.js',
\'~/projects/froala_editor_sources_2.4.2',
\'~/projects/broccoli-asset-rewrite'",
\]
