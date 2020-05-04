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
"   -> Plugins
"   -> Plugins setting
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

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Don't redraw while executing macros (good performance config)
" Use :redraw to force an update
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

" Enable folding
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

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

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


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
  " let g:solarized_termtrans=1
  " colorscheme solarized
  let g:badwolf_darkgutter = 1
  colorscheme badwolf
catch
endtry

" Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" set lcs=tab:\|\ ,eol:¶,extends:→,precedes:←,trail:·,nbsp:·,extends:»
" set lcs=tab:\|\ ,precedes:←,trail:·,nbsp:·,extends:»

" softwrap lines
set wrap linebreak nolist

" Number of spaces per Tab
set softtabstop=2

" Make tabs as wide as two spaces
set tabstop=2

" Number of auto-indent spaces
set shiftwidth=2

" Auto-indent new lines
set autoindent

" Enable smart-indent
set smartindent

" Enable smart-tabs
set smarttab

" Use spaces instead of tabs
set expandtab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => System setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " Use the OS clipboard by default (on versions compiled with `+clipboard`)

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

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
" Turn persistent undo on
try
  set undodir=~/.vim/undo
  set backupdir=~/.vim/backups
  set backupskip=/tmp/*,/private/tmp/*
  set directory=~/.vim/swaps
  set backup
  set undofile
  set writebackup
catch
endtry

" Number of undo levels
set undolevels=1000

" Don’t create backups when editing files in certain directories

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

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key binding & Custom Command
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :w!<cr>

" Change CWD of all windows
nnoremap <leader>cd :cd %:p:h<CR>

" Change CWD of current windows
nnoremap <leader>lcd :lcd %:p:h<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null

" Enable folding with the spacebar
nnoremap <space> za

" ESC key map
inoremap kj <ESC>

" strip white space
noremap <leader>ss :call StripWhitespace()<CR>

" turn off search highlight
nnoremap <leader>/ :nohlsearch<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Specify a directory for plugins
" " - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.vim/plugged')

" " fzf plugin
" Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf.vim'

" " ack plugin
" Plug 'mileszs/ack.vim'

" " restore view for fold & cursor & etc
" Plug 'vim-scripts/restore_view.vim'

" " Intellisense support
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

" " snippet
" " Plug 'Shougo/neosnippet'
" " Plug 'Shougo/neosnippet-snippets'

" " python support
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" " Initialize plugin system
" call plug#end()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for restore_view.vim
set viewoptions=cursor,folds,slash,unix
let g:skipview_files = ['*\.vim']

" for deoplete.vim's requirements: nvim-yarp
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" for deoplete-jedi plugin
let g:deoplete#sources#jedi#statement_length=100
let g:jedi#completions_enabled = 0

" buildin netrw setting
let g:netrw_liststyle = 3 " list in tree view

" set new command of fzf.vim
command! -bang -nargs=? -complete=dir DotFiles
  \ call fzf#vim#files(<q-args>, {'source': 'rg --hidden --ignore-file .git -H ""'}, <bang>0)
