if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" disable vi compatibility
set nocompatible

call plug#begin('~/.vim/plugged')

" add vim-plug for helpfiles
Plug 'junegunn/vim-plug'
" == GENERIC-USE / AUGMENTING PLUGINS
Plug 'vim-scripts/L9'
Plug 'chriskempson/base16-vim'
Plug 'Yggdroot/LeaderF'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'wellle/targets.vim'
Plug 'SirVer/ultisnips'
Plug 'junkdeck/vim-snippets'
Plug 'easymotion/vim-easymotion'
Plug 'aykamko/vim-easymotion-segments'
Plug 'tomtom/tcomment_vim'
Plug 'tmhedberg/matchit'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/loremipsum'
Plug 'ReekenX/vim-rename2'
Plug 'chaoren/vim-wordmotion'
Plug 'calviken/vim-gdscript3'
Plug 'junegunn/fzf.vim'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'mileszs/ack.vim'
Plug 'jreybert/vimagit'
Plug 'NLKNguyen/c-syntax.vim'
" == WEB DEVELOPMENT PLUGINS ==
Plug 'mattn/emmet-vim'
" Plug 'ap/vim-css-color'
Plug 'prettier/vim-prettier'
Plug 'wesQ3/vim-windowswap'
Plug 'mattn/webapi-vim'
" == SYNTAX / HIGHLIGHTING  ==
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mxw/vim-jsx'
Plug 'isRuslan/vim-es6'
Plug 'Quramy/vim-js-pretty-template'
" Plug 'alampros/vim-styled-jsx'
Plug 'hail2u/vim-css3-syntax'
" Plug 'posva/vim-vue'

" All plugins must be added before following line
call plug#end()

" CUSTOM FUNCTIONS
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

set rtp+=~/.fzf

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
set expandtab         " spaces instead of tabs
set autoindent        " autoindents based on above
set tabstop=2         " inserts x spaces when tab is pressed
set softtabstop=2     " insert-mode, xspace tabs
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
" disables esckeys (removes delay when 'O'pening new line)
"set noesckeys 
" set color scheme
let base16colorspace=256
colorscheme base16-default-dark 
" disables opague background
hi Normal ctermbg=none
hi NonText ctermbg=none

" == PLUGIN CONFIGURATION ==
" let vim-ack use Ag (if exists)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" vim-prettier setup
let g:prettier#config#print_width = 80
let g:prettier#exec_cmd_async = 1 " asynchronous formatting
let g:prettier#autoformat = 0 " disable formatting off iles that have @format tag
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
"let g:prettier#config#use_tabs = 'true' "ugh use tabs instead of spaces
let g:prettier#config#tab_width = 2
let g:prettier#config#semi = 'false'
let g:prettier#config#bracket_spacing = 'false'
" vim-jsx works on js files and jsx
let g:jsx_ext_required = 0
" vim-glsl 
let g:glsl_file_extensions = '*.shader'
" UltiSnips options
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
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
" if has('autocmd')
"   " Support `-` in css property names
"   augroup VimCSS3Syntax
"     autocmd!
"     autocmd FileType css setlocal iskeyword+=-
"   augroup END
"
"   call jspretmpl#register_tag('css', 'scss')
"
"   autocmd FileType javascript.jsx JsPreTmpl css
" endif

" only show relative line numbers in active window and insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" == KEY MAPPING ==
" fugitive maps
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
" Ack leader
nnoremap <Leader>a :Ack<Space>
" Quickfix mappings
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>
" remove search highlight
nnoremap <Leader>n :noh<CR>
" window manipulation maps
map - <C-w>-
map + <C-w>+
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" temporarily remove search highlighting
" nnoremap <CR> :noh<CR>
" map Expander to <CR> in insert mode
inoremap <expr> <CR> Expander()
" * doesnt jump forward
nnoremap * *``
" terminal mapping
tnoremap <Esc> <C-\><C-n> " exits terminal mode
