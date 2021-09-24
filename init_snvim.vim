" ---------------------- USABILITY CONFIGURATION ----------------------
"  Minimal config file
" Intended to be used with the snvim bash script
" The script controls the making of the .orig file so empty .orig
" files are not made when the file did not exist to begin with.

" don't make vim compatible with vi, otherwise it conflicts with Vundle and
" other plugins
set nocompatible

" **** General behavior -- things most likely to be edited early in the file

" Change the leader key -- default is "\"
" Do this first early so references below use the new leader
let mapleader = ","

" set how many lines to read variables from
set modelines=0

" setup backup undo and swap related settings
set backup
set swapfile
set backupext=.bak
" make sure the directories exist first.
call mkdir($HOME."/.config/nvim", "p", 0770)
call mkdir($HOME."/.config/nvim/.undo", "p", 0700)
set undodir=~/.config/nvim/.undo//
call mkdir($HOME."/.config/nvim/.swap", "p", 0700)
set directory=~/.config/nvim/.swap//
call mkdir($HOME."/.config/nvim/.backup", "p", 0700)
set backupdir=~/.config/nvim/.backup//
" Prevent vim from making the .orig file -- the bash script will do this
"set patchmode=.orig

" turn on syntax highlighting
syntax on

" show line numbers
set number

" show file stats
set ruler

" status bar, mode, command
set laststatus=2 
set showmode
set showcmd

" help quick screen redraw
set ttyfast

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" enable mouse support for scrolling
set mouse=a

" make a mark for column 80, but wrap after 120 columnns
" Filetype specifics are set below
set colorcolumn=80
set textwidth=120
" set wrap on by default
set wrap
set linebreak

" by default, in insert mode backspace won't delete over line breaks, or 
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" Blink cursor on error instead of beeping (grrr)
" set visualbell

" reload files changed outside vim
set autoread         

" use the system clipboard
" Raspberry Pi or other headless server via SSH, I used xsel
" and SSH X11 forwarding on server /etc/ssh/sshd_config and on
" client (/etc/ssh/ssh_config or in the config file as ForwardX11 yes
set clipboard=unnamedplus

" allow hidden buffers -- dont't unload buffers when they are abandoned
" instead stay in the background
set hidden

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" underline the line the cursor is on
" Cursor highlight taken care of by color scheme
set cursorline

" Open splits on the bottom and right. Default is above and left
set splitbelow
set splitright 

" **** Command mapping
" Allow saving of files as sudo when I forgot to open them as sudo.
" This sends the buffer contents to the shell command tee which is run as sudo,
" and writes the buffer to the current file name
cmap Sw w !sudo tee > /dev/null %

" FOR TRAINING, Remap arrow keys in normal mode to not do anyting... at least for now
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" remap the escape key to something easier to reach
" there will be a slight pause after the first 'j' waiting for the next one
" but this is visual, and should not cause a typing issue
" Go to normal (command) mode and eat up the moving back of the cursor.
imap jj <Esc>l
" Eat up the moving back of the cursor when going to normal (command) mode.
" This is commented out, because it causes letters to be printed when the arrow
" keys are pressed.
"imap <Esc> <Esc>l

" map <leader>O in normal modde to insert a line above without staying in insert mode
" map <leader>o in normal mode to insert a line below without staying in insert mode
nmap <leader>O O<Esc>
nmap <leader>o o<Esc>

" Make navigation for split windows easier
" Use the normal navigation keys and Ctrl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" map the underscore = to a + so when using +/- to navigate up and down a line,
" the shift is not needed for the +
nnoremap = +

" opening additional buffers (files)
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>sp :sp <C-R>=expand("%:p:h") . "/" <CR>
" assume vertical split unless sp is used.
map <leader>s :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>vsp :vsp <C-R>=expand("%:p:h") . "/" <CR>

" List contents of all registers (that typically contain pasteable text).
" i.e. shortcut for :reg/:registers
nnoremap <silent> "" :registers ".0123456789abcdefghijklmnopqrstuvwxyz-*+%/#<CR>

" **** Formatting

" Treat ejs file as html
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.hbs set filetype=handlebars
" treat *.js, *.mjs, *.cjs as javascript
au BufNewFile,BufRead *.js,*.cjs,*.mjs set filetype=javascript

" Indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
" default to 4 tabs.  File specific settings below
set shiftwidth=4    " when reading, tabs are 4 spaces
set softtabstop=4   " in insert mode, tabs are 4 spaces
set tabstop=4

" Searching
"nnoremap / /\v
"vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
"map <leader><space> :let @/=''<cr> " clear search

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
" nnoremap <space> za

" **** File format related
" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" **** Other settings

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" suggestion for normal mode commands
set wildmode=list:longest

" ---------------------- PLUGIN CONFIGURATION ----------------------
" Use vim-plug to manage plugins
" Vundle and perhaps other plugins have trouble when filetype is on
" Turn off for now -- turn back on after plugins
" filetype off
" filetype plugin indent off

" initiate vim-plug
" call plug#begin('~/.config/nvim/bundle/')
"
" **** DO PLUGIN STUFF HERE
"
" end plugin definition
" call plug#end()            " required for vim-plug

" filetype off for plugins to load correctly -- turn it on now
" filetype plugin indent on
" ---------------------- End Plugin Management ----------------------

" ---------------------- Color Schemes ----------------------
"  Do after plugin stuff, otherwise there seems to be problems. Not sure why.

" **** Color scheme (terminal)
"set t_Co=256

if (has("termguicolors"))                                                               
  set termguicolors                                                                     
endif

" Palenight
set background=dark
" colorscheme palenight

" Solarized
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.config/nvim/colors/ and uncomment:
"colorscheme solarized

" Wombat
" set the color theme to wombat256
"colorscheme wombat256
" and set the mark color to DarkSlateGray
"highlight ColorColumn ctermbg=lightgray guibg=lightgray

" set spelling errors to use underlines rather than red squiggly in terminals.
" The red squiggly does not show up in terminals.
" from solarized.vim color scheme file (for reference, not to be uncommented)
"exe "hi! SpellBad"       .s:fmt_curl   .s:fg_none   .s:bg_none    .s:sp_red
"exe "hi! SpellCap"       .s:fmt_curl   .s:fg_none   .s:bg_none    .s:sp_violet
"exe "hi! SpellRare"      .s:fmt_curl   .s:fg_none   .s:bg_none    .s:sp_cyan
"exe "hi! SpellLocal"     .s:fmt_curl   .s:fg_none   .s:bg_none    .s:sp_yellow

if &termguicolors
  hi SpellBad gui=undercurl cterm=underline term=underline ctermfg=red
  hi SpellCap gui=undercurl cterm=underline term=underline ctermfg=magenta
  hi SpellRare gui=undercurl cterm=underline term=underline ctermfg=cyan
  hi SpellLocal gui=undercurl cterm=underline term=underline ctermfg=yellow
else
  hi SpellBad gui=undercurl cterm=underline term=underline ctermbg=DarkMagenta ctermfg=Yellow
  hi SpellCap gui=undercurl cterm=underline term=underline ctermfg=magenta
  hi SpellRare gui=undercurl cterm=underline term=underline ctermfg=cyan
  hi SpellLocal gui=undercurl cterm=underline term=underline ctermbg=Magenta ctermfg=LightYellow
endif

" set spelling language, but turn spelling check off by default.
" Allow ftplugin/.vim files turn it on if wanted.
set spelllang=en_us
set nospell

" Format options
" Set formating options after filetype plugin runs to prevent
"" them from being overwritten by ftplugin
"set formatoptions=tcqrn1
"tcq is default
set formatoptions=tcqr

" Turn off settings in 'formatoptions' relating to comment formatting.
" - t : Auto-wrap text using textwidth
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - q :	Allow formatting of comments with 'gq'.
"	    Note that formatting will not change blank lines or lines containing
"   	only the comment leader.  A new paragraph starts after such a line,
"	    or when the comment leader changes.
"
" - r : do not insert the comment leader when hitting <Enter> in insert mode
setlocal formatoptions-=o

" ---------------------- USER FUNCTIONS ----------------------
"
" Show syntax highlighting groups for word under cursor
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command! CHECKSYNTAX call SynStack()

" Prose or Word Processor Mode
func! Prose()
    echo "Enter Prose/Word Processor Mode (user function)"
    " formatoptions
    " l	Long lines are not broken in insert mode: When a line was longer than
    "   'textwidth' when the insert command started, Vim does not
    "	automatically format it.
    setlocal formatoptions=l
    setlocal noexpandtab
    " j moves down a line, gj moves down one display line
    map j gj
    map k gk
    " spelling and thesaurus
    setlocal spell spelllang=en_us
    " set thesaurus+= <path to thesaurus file>
    " set complete+=s
    " use the par formatter
    set formatprg=par
    setlocal wrap
    setlocal linebreak
endfu
command! WP call Prose()
command! PROSE call Prose()



