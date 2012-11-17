" brew install
" https://raw.github.com/gist/3173834/9b8e7a0a922e126c0e36783c5e923e38fd0aa62e/vim.rb


" ==========================================================
" Vundler setup
" ==========================================================

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" ==========================================================
" Bundles
" ==========================================================

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-surround'
Bundle 'YankRing.vim'
Bundle 'scrooloose/syntastic'
"Bundle 'tpope/vim-fugitive'   " Git

""" Command-T
" Don't forget to compile C extension
"  $ cd ~/.vim/bundle/command-t/ruby/command-t
"  $ /usr/bin/ruby extconf.rb
"  $ make
Bundle 'git://git.wincent.com/command-t.git'

Bundle 'git://github.com/tpope/vim-rails.git'

filetype plugin indent on     " required!

" ==========================================================
" Shortcuts
" ==========================================================

" Change the leader to be a comma vs slash
let mapleader=","

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" sudo write this
cmap W! w !sudo tee % >/dev/null

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" ==========================================================
" Plugin Settings
" ==========================================================

" ==========================================================
" General VIM Settings
" ==========================================================

syntax on                       " syntax highlighing
filetype on                     " try to detect filetypes
filetype plugin indent on       " enable loading indent file for filetype
set number                      " Display line numbers
set numberwidth=1               " using only 1 column (and 1 space) while possible
set background=dark             " We are using dark background in vim
set title                       " show title in console title bar
set wildmenu                    " Menu completion in command mode on <Tab>
set wildmode=full               " <Tab> cycles between all matching choices.
set colorcolumn=80

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.git,*.pyc

set grepprg=ack                 " replace the default grep program with ack

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6                 " Keep a small completion window

""" Moving Around/Editing
set mouse=a                     " yay- let's use a mouse
set cursorline                  " have a line indicate the cursor location
set ruler                       " show the cursor position all the time
set nostartofline               " Avoid moving cursor to BOL when jumping around
set virtualedit=block           " Let cursor move past the last char in <C-v> mode
set scrolloff=5                 " Keep 3 context lines above and below the cursor
set backspace=indent,eol,start  " backspace through everything in insert mode
set showmatch                   " Briefly jump to a paren once it's balanced
set nowrap                      " don't wrap text
set linebreak                   " don't wrap textin the middle of a word
set autoindent                  " always set autoindenting on
set smartindent                 " use smart indent if there is no indent file
set tabstop=4                   " <tab> inserts 4 spaces
set shiftwidth=4                " but an indent level is 2 spaces wide.
set softtabstop=4               " <BS> over an autoindent deletes both spaces.
set expandtab                   " Use spaces, not tabs, for autoindent/tab key.
set shiftround                  " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>             " show matching <> (html mainly) as well
set foldmethod=indent           " allow us to fold on indents
set foldlevel=99                " don't fold by default

"""" Reading/Writing
set encoding=utf-8
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
let g:Powerline_symbols = 'fancy'

syntax enable
set background=dark
colorscheme ir_black

" set the backup dir to declutter working directory.
" two ending slashes means, full path to the actual filename
" -- thanks to indygemma
silent! !mkdir -p ~/.vim/backup
silent! !mkdir -p ~/.vim/swap
silent! !mkdir -p ~/.vim/undo
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
" Persistent undos (vim 7.3+)
set undofile
set undodir=~/.vim/undo/

" ===========================================================
" FileType specific changes
" ============================================================

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json set ft=javascript

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <=line("$")
    \| exe "normal! g`\"" | endif

""" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

""" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=100 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufNewFile,BufRead *.tac setlocal ft=python
au BufRead *.py,*.tac set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\%l%.%#,%Z%[%^\ ]%\\@=%m

" Omni Completion
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType python set omnifunc=pythoncomplete#Complete
au FileType php set omnifunc=phpcomplete#CompletePHP

" Use indent as foldmethod in python.
" http://stackoverflow.com/questions/357785/what-is-the-recommended-way-to-use-vim-folding-for-python-coding
au FileType python set foldmethod=indent
" Do not fold internal statements.
au FileType python set foldnestmax=2

au FileType javascript setlocal tabstop=2 softtabstop=2 tabstop=2 shiftwidth=2
