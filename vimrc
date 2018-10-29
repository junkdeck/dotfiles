" disable vi compatibility
set nocompatible
" == VUNDLE SETUP ==
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
" == GENERIC-USE / AUGMENTING PLUGINS
Plugin 'vim-scripts/L9'
Plugin 'scrooloose/nerdtree'
Plugin 'chriskempson/base16-vim'
Plugin 'Yggdroot/LeaderF'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'jiangmiao/auto-pairs'
Plugin 'wellle/targets.vim'
Plugin 'SirVer/ultisnips'
Plugin 'junkdeck/vim-snippets'
Plugin 'easymotion/vim-easymotion'
Plugin 'aykamko/vim-easymotion-segments'
Plugin 'tomtom/tcomment_vim'
Plugin 'tmhedberg/matchit'
Plugin 'Yggdroot/indentLine'
Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/loremipsum'
Plugin 'Rename2'
Plugin 'chaoren/vim-wordmotion'
Plugin 'calviken/vim-gdscript3'
" == WEB DEVELOPMENT PLUGINS ==
Plugin 'mattn/emmet-vim'
" Plugin 'ap/vim-css-color'
Plugin 'prettier/vim-prettier'
Plugin 'wesQ3/vim-windowswap'
Plugin 'mattn/webapi-vim'
" == SYNTAX / HIGHLIGHTING  ==
Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
" Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'mxw/vim-jsx'
Plugin 'isRuslan/vim-es6'
Plugin 'Quramy/vim-js-pretty-template'
" Plugin 'alampros/vim-styled-jsx'
Plugin 'hail2u/vim-css3-syntax'
" Plugin 'posva/vim-vue'

" All plugins must be added before following line
call vundle#end()
" enable plugins and indentations
filetype plugin indent on
" syntax highlighting
syntax on

" Vundle help
"	:PluginList 		- lists all configured plugins
"	:PluginInstall		- installs plugins - append `!` to update
"	:PluginUpdate		- updates plugins
"	:PluginSearch foo	- searches for `foo` - append `!` to refresh local cache
"	:PluginClean		- confirms removal of unused plugins - append `!` to auto-approve removal 
"	:h vundle		- more details
"
"	CUSTOM FUNCTIONS
" HTML-TAG AUTOINDENT ON <CR>
" snippet from https://stackoverflow.com/a/18066591/4881742
function! Expander()
  let line    = getline(".")
  let col     = col(".")
  let first   = line[col-2]
  let second  = line[col-1]
  let third   = line[col]

  if first ==# ">"
    if second ==# "<" && third ==# "/"
      return "\<CR>\<C-o>==\<C-o>O"
    else
      return "\<CR>"
    endif
  else
    return "\<CR>"
  endif
endfunction

" == CORE FUNCTIONALITY CONFIGURATION ==
" hybrid line numbers, display current line as absolute, rest as relative
set number relativenumber
" reload files changed outside vim
set autoread
" utf-8 encoding
set encoding=utf-8
set fileencoding=utf-8
" screen will not be redrawn while running non-typed commands
set lazyredraw
" set gui font for gvim
set guifont=Terminus
" 256 color term support
set t_Co=256
" find next match as it's typed
set incsearch
" highlight search matches
set hlsearch
" keep the cursor within 3 lines when scrolling
set scrolloff=4
" backspace fix
set backspace=indent,eol,start
" indentation
set expandtab		      " spaces instead of tabs
set autoindent		    " autoindents based on above
set tabstop=2         " inserts x spaces when tab is pressed
set softtabstop=2	    " insert-mode, xspace tabs
set shiftwidth=2      " indentation space characters
" tab characters
set list
set listchars=tab:\|·
" lightline fix
set laststatus=2
" remove redundant '-- INSERT --', thanks lightline
set noshowmode
" case insensitive search - use \C for sensitive
set ignorecase
" ignores case on lowercase, case sensitive on uppercase
set smartcase
" set color scheme
let base16colorspace=256
colorscheme base16-default-dark 
" disables opague background
hi Normal ctermbg=none
hi NonText ctermbg=none

" == PLUGIN CONFIGURATION ==
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
" retain vanilla conceal settings for indentLine
let g:indentLine_setConceal = 0
" vim-prettier setup
let g:prettier#config#print_width = 80
let g:prettier#exec_cmd_async = 1 " asynchronous formatting
let g:prettier#autoformat = 0 " disable formatting off iles that have @format tag
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
let g:prettier#config#use_tabs = 'true' "ugh use tabs instead of spaces
let g:prettier#config#tab_width = 4
let g:prettier#config#semi = 'false'
" vim-jsx works on js files and jsx
let g:jsx_ext_required = 0
" vim-glsl 
let g:glsl_file_extensions = '*.shader'
" UltiSnips options
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z"
let g:UltiSnipsEditSplit="vertical"
" redefine emmet key - trailing , still needed!
let g:user_emmet_leader_key='<C-e>'
" let emmet expand class to className in jsx files
let g:user_emmet_settings = {
  \'javascript.jsx':{
  \ 'extends': 'jsx'
  \}
\}
" lightline setup - colorscheme and branch name
let g:lightline = {
  \'colorscheme':'nord',
  \'active': {
  \  'left': [['mode', 'paste'],
  \  ['gitbranch', 'readonly', 'filename', 'modified']]
  \},
  \'component_function': {
  \'gitbranch': 'fugitive#head'
  \},
\}
" == TEMPLATE LITERAL HIGHLIGHTING ==
if has('autocmd')
  " Support `-` in css property names
  augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css setlocal iskeyword+=-
  augroup END

  call jspretmpl#register_tag('css', 'scss')

  autocmd FileType javascript.jsx JsPreTmpl css
endif

" only show relative line numbers in active window and insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" == KEY MAPPING ==
" window manipulation maps
map - <C-w>-
map + <C-w>+
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" bind NERDTree to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" temporarily remove search highlighting
nnoremap <CR> :noh<CR>
" map Expander to <CR> in insert mode
inoremap <expr> <CR> Expander()
" * doesnt jump forward
nnoremap * *``
