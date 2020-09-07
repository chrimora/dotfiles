" Plugins
" https://github.com/tpope/vim-pathogen
" https://github.com/vim-airline/vim-airline
" https://github.com/morhetz/gruvbox

" https://github.com/tpope/vim-repeat
" https://github.com/Townk/vim-autoclose
" https://github.com/tpope/vim-surround
" https://github.com/preservim/nerdtree
" https://github.com/vim-syntastic/syntastic
" https://github.com/mg979/vim-visual-multi

" Font
" https://github.com/tonsky/FiraCode
if has("gui_running")
    set guioptions=!gt
    set guifont=Fira_Code:h10:cANSI:qDRAFT
endif

execute pathogen#infect()

" airline
let g:airline#extensions#tabline#enabled=1
let g:airline_section_z='%3l/%L:%3v'
let g:airline_skip_empty_sections = 1

" gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=0
colorscheme gruvbox

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
let g:syntastic_enable_balloons = 0

" Mappings
" Cycle buffers
nmap <C-Tab>   :bn<Enter>
nmap <C-S-Tab> :bp<Enter>
" Toggle NERDTree
nmap <C-o> :NERDTreeToggle<Enter>

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
set showcmd
set noshowmode
set ignorecase
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=full
set backspace=indent,eol,start
set ssop-=options

" FileType plugin overwrites this
" set formatoptions=crql
autocmd FileType * set formatoptions=crql

" Line wrapping
set wrap
set linebreak
set textwidth=80
set colorcolumn=85

" Tabs are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Save vim session
function! MakeSession(n)
  let b:sessiondir = $HOME . '\vimfiles\sessions'
  let b:file = b:sessiondir . '\session' . a:n . '.vim'
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir ' b:sessiondir
    redraw!
  endif
  exe 'mksession! ' b:file
  echo 'Session' . a:n . ' saved.'
endfunction
function! LoadSession(n)
  let b:sessiondir = $HOME . '\vimfiles\sessions'
  let b:file = b:sessiondir . '\session' . a:n . '.vim'
  if (filereadable(b:file))
    exe 'silent source ' b:file
    echo 'Session' . a:n . ' loaded.'
  else
    echo 'No session loaded.'
  endif
endfunction
" Auto save session on close
au VimLeave * :call MakeSession('')
nmap <C-Enter> :call LoadSession('')<Enter>
" Save/Load up to 3 sessions
nmap <C-S-F1> :call MakeSession('1')<Enter>
nmap <C-F1> :call LoadSession('1')<Enter>
nmap <C-S-F2> :call MakeSession('2')<Enter>
nmap <C-F2> :call LoadSession('2')<Enter>
nmap <C-S-F3> :call MakeSession('3')<Enter>
nmap <C-F3> :call LoadSession('3')<Enter>
