" Windows gVim config

" Plugins
" https://github.com/tpope/vim-pathogen

" https://github.com/dense-analysis/ale
" https://github.com/sainnhe/everforest
" https://github.com/morhetz/gruvbox
" https://github.com/vim-airline/vim-airline
" https://github.com/Townk/vim-autoclose
" https://github.com/sheerun/vim-polyglot
" https://github.com/tpope/vim-repeat
" https://github.com/airblade/vim-rooter
" https://github.com/tpope/vim-surround
" https://github.com/tpope/vim-unimpaired

" https://github.com/junegunn/fzf
" https://github.com/junegunn/fzf.vim
" Install ripgrep and bat
" Ensure bash on path

" call pathogen#helptags()

" Font
" https://github.com/tonsky/FiraCode
if has("gui_running")
    set guioptions=!gt
    set guifont=Fira_Code:h10:cANSI:qDRAFT
endif

if has('termguicolors')
  set termguicolors
endif

execute pathogen#infect()

" color settings
let g:gruvbox_bold=0
let g:everforest_better_performance = 1
colorscheme everforest

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_z = '%3l/%L:%3v'
let g:airline_skip_empty_sections = 1

" ALE
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

nnoremap <leader>ad :ALEGoToDefinition<Enter>
nnoremap <leader>ar :ALEFindReferences -quickfix<Enter>:copen<Enter>

let g:ale_python_flake8_options = '--ignore=E501' " Lines too long
let g:ale_linters = {
\   'python': ['flake8', 'pyright'],
\}

let g:ale_fix_on_save = 1
let g:ale_python_autoflake_options = '--remove-all-unused-imports --remove-unused-variables'
let g:ale_prettier_options = '--tab-width 4'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autoflake', 'isort', 'black'],
\   'css': ['prettier'],
\   'javascript': ['prettier'],
\}

" matchit - allows % on tags
packadd! matchit

" Disable arrows in normal mode
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" Cycle buffers
nmap gb :bn<Enter>
nmap gB :bp<Enter>

" Remove extra backup files
set nobackup
set noundofile

" General
syntax on
filetype plugin indent on
set number
set relativenumber
set cursorline
set background=dark
set nocompatible
set hidden
set autochdir
set showcmd
set noshowmode
set ignorecase
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=full
set backspace=indent,eol,start
set sessionoptions-=options
set viewoptions-=options
set foldmethod=indent
set foldlevel=99

" FileType plugin overwrites this
" set formatoptions=crql
autocmd FileType * set formatoptions=crql

" Line wrapping
set wrap
set linebreak
set textwidth=80
set colorcolumn=85

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" fzf related
let g:fzf_layout = {'down':'20'}
let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git']
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(FindRootDirectory(), fzf#vim#with_preview({"options": ['--layout=reverse', "--exact"]}), <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({"options": ['--layout=reverse', "--exact"], "dir": FindRootDirectory()}), <bang>0)

" Save vim session
function! MakeSession(n)
  let b:sessiondir = $HOME . '/.vim/sessions'
  let b:file = b:sessiondir . '/session' . a:n . '.vim'
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir ' b:sessiondir
    redraw!
  endif
  exe 'mksession! ' b:file
  echo 'Session' . a:n . ' saved.'
endfunction
function! LoadSession(n)
  let b:sessiondir = $HOME . '/.vim/sessions'
  let b:file = b:sessiondir . '/session' . a:n . '.vim'
  if (filereadable(b:file))
    exe 'silent source ' b:file
    echo 'Session' . a:n . ' loaded.'
  else
    echo 'No session loaded.'
  endif
endfunction

" Auto save session on close
autocmd VimLeave * :cclose " quickfix isnt saved into session

" Save/Load up to 3 sessions
autocmd VimLeave * :call MakeSession('1')
nmap <leader>l1 :call LoadSession('1')<Enter>
nmap <leader>s2 :call MakeSession('2')<Enter>
nmap <leader>l2 :call LoadSession('2')<Enter>
nmap <leader>s3 :call MakeSession('3')<Enter>
nmap <leader>l3 :call LoadSession('3')<Enter>
