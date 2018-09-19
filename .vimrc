"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"   JMwill
"
"
" Sections:
"   -> Reconfig default setting
"   -> User Interface
"   -> Themes & Colors & Fonts
"   -> System setting
"   -> Files & Backups & Undo
"   -> Functions
"   -> Key binding & Custom Command
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Reconfig default setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set how many lines of history VIM has to remember
set history=1000
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Enhance command-line completion, Turn on the Wild menu
set wildmenu

" Show line numbers
set number

" Always show cursor position (show row and column ruler information)
set ruler

" Highlight matching brace
set showmatch

" Make Vim more useful
set nocompatible

" Highlight all search results
set hlsearch

" Enable smart-case search
set smartcase

" Always case-insensitive
set ignorecase

" Searches for strings incrementally
set incsearch

" Number of undo levels
set undolevels=1000

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Highlight current line
set cursorline

" Always show status line
set laststatus=2

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the (partial) command as it’s being typed
set showcmd

" Use relative line numbers
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes & Colors & Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

try
  " Use the Solarized Dark theme
  " set background=dark
  let g:solarized_termtrans=1
  colorscheme solarized
catch
endtry

set background=dark

" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set lcs=tab:\|\ ,eol:¶,extends:→,precedes:←,trail:·,nbsp:·,extends:»
set lcs=tab:\|\ ,precedes:←,trail:·,nbsp:·,extends:»
set list

" Break lines at word (requires Wrap lines)
set linebreak

" Line wrap (number of cols)
set textwidth=120

" Auto-indent new lines
set autoindent

" Enable smart-indent
set smartindent

" Make tabs as wide as two spaces
set tabstop=2

" Enable smart-tabs
set smarttab

" Number of spaces per Tab
set softtabstop=2

" Use spaces instead of tabs
set expandtab

" Number of auto-indent spaces
set shiftwidth=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => System setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Allow cursor keys in insert mode
set esckeys

" Optimize for fast terminal connections
set ttyfast

" Enable mouse in all modes
set mouse=a

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files & Backups & Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Or Turn backup off, since most stuff is in SVN, git et.c anyway...
" set nobackup
" set nowb
" set noswapfile

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key binding & Custom Command
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Enable folding with the spacebar
nnoremap <space> za

" ESC key map
inoremap kj <ESC>`^

" strip white space
noremap <leader>ss :call StripWhitespace()<CR>

