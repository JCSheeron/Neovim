" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

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
" make the first backup special (create the *.orig file)
set patchmode=.orig

" turn on syntax highlighting
let python_highlight_all=1
syntax on

" show line numbers
set number

" show file stats
set ruler

" status bar
set laststatus=2 

" last line
" showmode is not needed with lightline plugin (cfg below)
"set showmode
set noshowmode
set showcmd

" help quick screen redraw
set ttyfast

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" enable mouse support for scrolling
set mouse=a

" Make a mark for column 80.
" textwidth controls width of inserted text and comments. See formatoptions.
" Filetype specifics are set below
" NOTE: vim-pencil plugin will alter this behavior when active
set colorcolumn=80
set textwidth=120
" Wrap and linebreak change how long lines are displayed, but don't alter the file content.
set wrap
set linebreak

" set file type specifics in the ~/.vim/ftplugin/<filetype.vim> file

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
" These make it easier to open a file in the current directory by
" prepending the current directory
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>sp :sp <C-R>=expand("%:p:h") . "/" <CR>
" assume vertical split unless sp is used.
map <leader>s :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>vsp :vsp <C-R>=expand("%:p:h") . "/" <CR>

" List contents of all registers (that typically contain pasteable text).
" i.e. shortcut for :reg/:registers
nnoremap <silent> "" :registers ".0123456789abcdefghijklmnopqrstuvwxyz-*+%/#<CR>

" remap keys for coc-prettier
" use leader f for Format
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Coc-snippets key maps
" Set filetype" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)s

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"WAS LIKE THIS
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Set up the command to use :Prettier to format a file
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" neomake
nmap <Leader>no :lopen<CR>      " open location window
nmap <Leader>nc :lclose<CR>     " close location window
nmap <Leader>n, :ll<CR>         " go to current error/warning
nmap <Leader>nn :lnext<CR>      " next error/warning
nmap <Leader>np :lprev<CR>      " previous error/warning


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
" default to 4 tabs.  
" For the amount of space used for a new tab use shiftwidth.
" Set file type specifics in the ~/.config/nvim/after/ftplugin/<filetype.vim> file
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
filetype off
filetype plugin indent off

" tell NeoVim where to find NodeJs. Helpful when nvm is used and different versions
" are installed. Sometimes this causes issues with right click launch
" let g:node_host_prog = '/home/jcsheeron/.nvm/versions/node/v13.3.0/lib/node_modules/neovim/bin/'
"
" initiate vim-plug
call plug#begin('~/.config/nvim/bundle/')

" Palenight solorscheme
Plug 'drewtempelmeyer/palenight.vim'

" nerdtree file tree
Plug 'scrooloose/nerdtree'
" toggle on leader n or Ctrl-n
map <leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>
" how to ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" start nerdtree upon vim startup
" autocmd vimenter * NERDTree
" start nerdtree automatically on startup if no file is specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" start NERDTree on start-up and focus active window
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p


" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" let g:NERDDefaultAlign = 'start'
" if defaultAlign is 'start' then also  disable NERDRemoveExtraSpaces
" let g:NERDRemoveExtraSpaces = 0
"

" place, toggle and display marks
Plug 'kshenoy/vim-signature'

" buffer management
" Use Denite instead
"Plug 'Buffergator'

" Language Server Protocol (LSP)
" This plugin is a collection of common configurations for the build in
" language server client.
" coc-sh (shell) uses LSP for example
Plug 'neovim/nvim-lspconfig'


" coc for auto complete, linting, code fixing
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" set coc path in .profile instead. Could be in .bashrc, but then gui launch path is wrong?? Not sure about this.
" let g:coc_node_path = '/home/jcsheeron/.nvm/versions/node/v16.10.0/bin/node'
" Used honza/vim-snippets as the snippet source. Made a copy in a folder I could control and then
" removed it so I had control of the snippets
"Plug 'honza/vim-snippets'
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-yaml', 'coc-prettier', 'coc-tsserver', 'coc-pyright', 'coc-snippets', 'coc-sh']


" Use Emmet for Web Dev HTML, CSS, etc.
Plug 'mattn/emmet-vim'

" Emmet default trigger is <c-y>. This is clunky. Redefine.
let g:user_emmet_leader_key=',' " <,-emmetComand>
let g:user_emmet_settings = { 'javascript' : { 'extends' : 'jsx' } }
" Tell coc to use html.handlebars as a handlebars file.
" This is for compatibility between mustache/vim-mustahce-handlebars plugin
" and coc-html.  For whatever reason, I cannot get coc-html to work with a
" html.handlebars filetype, despite setting the html.filetyes setting of 
" coc-html in the coc-settings.json file
let g:coc_filetype_map = {
      \ 'html.handlebars': 'html',
      \ 'html.mustache': 'html'
      \ }

"Use Denite for fuzzy file finding, file management, and project searching.
" Note:  denite requires Python 3.6
" Plug 'Shougo/denite.nvim'

"" *** Denite setup
"" Use ripgrep for searching current directory for files
"" By default, ripgrep will respect rules in .gitignore
""   --files: Print each file that would be searched (but don't search)
""   --glob:  Include or exclues files for searching that match the given glob
""            (aka ignore .git files)
""
"call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
"
"" Use ripgrep in place of "grep"
"call denite#custom#var('grep', 'command', ['rg'])
"
"" Custom options for ripgrep
""   --vimgrep:  Show results with every match on it's own line
""   --hidden:   Search hidden directories and files
""   --heading:  Show the file name above clusters of matches from each file
""   --S:        Search case insensitively if the pattern is all lowercase
"call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])
"
"" Recommended defaults for ripgrep via Denite docs
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'final_opts', [])
"
"" Remove date from buffer list
"call denite#custom#var('buffer', 'date_format', '')
"
"" Custom options for Denite
""   auto_resize             - Auto resize the Denite window height automatically.
""   prompt                  - Customize denite prompt
""   direction               - Specify Denite window direction as directly below current pane
""   winminheight            - Specify min height for Denite window
""   highlight_mode_insert   - Specify h1-CursorLine in insert mode
""   prompt_highlight        - Specify color of prompt
""   highlight_matched_char  - Matched characters highlight
""   highlight_matched_range - matched range highlight
"let s:denite_options = {'default' : {
"\ 'split': 'floating',
"\ 'start_filter': 1,
"\ 'auto_resize': 1,
"\ 'source_names': 'short',
"\ 'prompt': 'λ ',
"\ 'statusline': 0,
"\ 'highlight_matched_char': 'QuickFixLine',
"\ 'highlight_matched_range': 'Visual',
"\ 'highlight_window_background': 'Visual',
"\ 'highlight_filter_background': 'DiffAdd',
"\ 'winrow': 1,
"\ 'vertical_preview': 1
"\ }}
"
"" Loop through denite options and enable them
"function! s:profile(opts) abort
"  for l:fname in keys(a:opts)
"    for l:dopt in keys(a:opts[l:fname])
"      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
"    endfor
"  endfor
"endfunction
"
"call s:profile(s:denite_options)

" Syntax checking
" Use neomake instead of syntastic for syntax checking
Plug 'neomake/neomake'
" Help using local project config files rather than global
Plug 'benjie/neomake-local-eslint.vim'

" Syntax check when writing to a buffer 

Plug 'pangloss/vim-javascript'

" syntax highlighting for mustache and handlebars
Plug 'mustache/vim-mustache-handlebars'
let g:mustache_abbreviations = 1

" Plug vim-markdown for markdown (markup) support
" There are seveal options. I tried gabrielelana's version and couldn't tell 
" it was/wasn't doing.  Plastic boy (uses tabular) is another version I didn't try.
" Opted for vim-pandoc and associated syntax checker.
" Plug 'gabrielelana/vim-markdown'
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

" Integrate vim with pandoc converter and 
" support for pandoc markdown.
" Syntax checker isn't required, but is strongly recommended
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Enable pandoc functionality for markdown files while using the markdown
" file type and syntax.
" Setting `pandoc#filetypes#pandoc_markdown` to 0 will disable all pandoc
" functionality for markdown files, unless "pandoc" exists in the
" `pandoc#filetypes#handled` array.
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
"let g:pandoc#filetypes#pandoc_markdown = 0

" Markdown table mode, table generator
Plug 'dhruvasagar/vim-table-mode'
" see https://github.com/dhruvasagar/vim-table-mode
" Key mappings:
" Make a table on the fly: <leader>tm by default, or :TableModeToggle
" By default, toggle table mode on/off with <leader>tm
" map <leader>tm :TableModeToggle<CR> " This is the default mapping
"
" Table-ize exiting content:
" Visually select a csv section and call <leader>tt OR :Tableize 
" map <leader>tt :Tableize<CR> " mapped by default.
" Use a different delimiter than comma (,) by 
" calling :Tableize/{pattern}  e.g. :Tableize/; would use a semicolon (;)
"
" Cell text object:
" i| and a| for insert/append inner and around
"
" Delete row: <leader>tdd or preceed with [count] to delete multiple rows
" Defined by option g:table_mode_delete_row_map
"
" Delete column: <leader>tdc (defined by option g:table_mode_delete_column_map)
"
" Insert column: <leader>tic (defined by the option
" g:table_mode_insert_column_after_map (default) or g:table_mode_insert_column_before_map

" For vim-table
" 1. Enter the first line (header) using | as a colum delimiter
" 2. In the second line without leaving insert mode, enter || to enter a horizontal line.
" 3. Subsequent lines use | as a column delimiter
"
" let g:table_mode_corner='|'
let g:table_mode_corner='+'
let g:table_mode_align_char=':' " probably default
" Use the align char (:) to 'pull' the contents to one side. e.g.:
" | Right | Left | Default | Center |
" |------:|:-----|---------|:------:|
" |   12  |  12  |    12   |    12  | 

" From read.md on github,
" The following funcion and remap allows
" || or __ to enable/disable table mode
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'


" Plug vim-pencil for writing
" NOTE: This will change wrapping behavior set with textwidth above
Plug 'reedes/vim-pencil'
let g:pencil#mode_indicators= {'hard': 'pH', 'auto': 'pA', 'soft': 'pS', 'off': 'pencilOff',}
" hard line breaks or soft line wrap?
" set default, and then turn on pencil and init, based on file type
let g:pencil#wrapModeDefault= 'hard' " default is hard. Change to 'soft' if that is what you want
augroup pencil
  " first clear the command group
  autocmd!
  " leave argument out of pencil#init for auto detect
  " Comment out -- using pandoc instead
  "autocmd FileType markdown call pencil#init({'wrap': 'soft', 'autoformat': 0, 'textwidth': 82})
  "autocmd FileType text call pencil#init({'wrap': 'hard', 'autoformat': 0, 'textwidth': 82})
augroup END

" configurable status line
Plug 'itchyny/lightline.vim'      
    let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \ 'left': [ ['mode', 'paste'],
    \         ['readonly', 'filename', 'modified', 'spell', 'syntastic', 'pencilMode'] ],
    \ 'right': [ [ 'lineinfo' ], ['percent'], 
    \          [ 'fileformat', 'fileencoding', 'filetype' ] ] 
    \ },
    \ 'component': {
    \ 'filename': '%F',
    \ 'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \ 'pencilMode': '%{PencilMode()}'
    \ },
    \ 'component_function': {
    \ 'spell': 'SpellInfo'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' },
    \ 'component_expand': { 'syntastic': 'SyntasticStatuslineFlag' },
    \ 'component_type': { 'syntastic': 'error' }
    \}
let g:lightline.colorscheme = 'palenight'


" use this funcion to display the spelling info in the status line.
" Spelling language and spelling file it is specified
function! SpellInfo()
    return &spell ? &spellfile != '' ? 'L:' . &spelllang . ' F:' . &spellfile : 'L:' . &spelllang : 'no spell'
endfunction

" distraction free writing
" Goyo
Plug 'junegunn/goyo.vim'
" disable fancy lightline staus line, but turn on minimum stuff
function! s:goyo_enter()
  " goyo disables lightline by default.
  " Don't need to show mode with lightline, but lightline is normally shut off
  " by goyo, so reenable showmode.
  set showmode
endfunction

function! s:goyo_leave()
  " goyo re-enables lightline, so no need for showmode
  set noshowmode
  " reset spelling colors
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
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

Plug 'junegunn/limelight.vim'
" Limelight need to be able to calculate the dimming down of surrounding
" paragraphs. It can't do this by default with the solarized color scheme.
" Help it by giving it these definitions/parameters
  " Color name (:help cterm-colors) or ANSI code
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_ctermfg = 240
  
  " Color name (:help gui-colors) or RGB color
  let g:limelight_conceal_guifg = 'DarkGray'
  let g:limelight_conceal_guifg = '#777777'
  
  " Default: 0.5
  let g:limelight_default_coefficient = 0.7
  
  " Number of preceding/following paragraphs to include (default: 0)
  let g:limelight_paragraph_span = 1
  
  " Beginning/end of paragraph
  "   When there's no empty line between the paragraphs
  "   and each paragraph starts with indentation
  let g:limelight_bop = '^\s'
  let g:limelight_eop = '\ze\n^\s'
  
  " Highlighting priority (default: 10)
  "   Set it to -1 not to overrule hlsearch
  let g:limelight_priority = -1

" end plugin definition
call plug#end()            " required for vim-plug

" filetype off for plugins to load correctly -- turn it on now
filetype plugin indent on

" ---------------------- End Plugin Management ----------------------

" ---------------------- Config Neomake -----------------------------
" This needs to come after plugin management i.e. after call plug#end()
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
"call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
"call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
"call neomake#configure#automake('nrwi', 500)
"
" I am not sure how the enable_makers = ['eslint'] affects project vs global. 
" It seems to then not work well with project configs, paticularly in parent folders.
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_open_list=0 " don't open location-list on errors
" let g:neomake_open_list=2 " open location-list on errors
" let g:neomake_logfile ='/home/vmuser1/Desktop/neomake.log'

" ---------------------- LSP Setup ----------------------
" For Bash Language Server using the nvim-lspconfig
" This must go after call plug#end()
lua require'lspconfig'.bashls.setup{}


" ---------------------- Color Schemes ----------------------
"  Do after plugin stuff, otherwise there seems to be problems. Not sure why.

" **** Color scheme (terminal)
set t_Co=256

if (has("termguicolors"))                                                               
  set termguicolors                                                                    
endif

" Palenight
set background=dark
colorscheme palenight

" Solarized
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.config/nvim/colors/ and uncomment:
"colorscheme solarized

" set the color theme to wombat256
"colorscheme wombat256
" and set the mark color to DarkSlateGray
"highlight ColorColumn ctermbg=lightgray guibg=lightgray

" Some terminals can't show squiggly lines, so spelling errors won't show.
" Set spelling errors to use underlines rather than red squiggly in terminals.
" Also some color schemes have difficult/impossible to read highlights depending
" on if termguicolors is on or off.  Provide a easy place to customize.
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
" 
" Format options
" Set formating options after filetype plugin runs to prevent
" them from being overwritten by ftplugin
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


" map FuzzyFinder
"noremap <leader>b :FufBuffer<cr>
"noremap <leader>f :FufFile<cr>

" use zencoding with <C-E>
"let g:user_emmet_leader_key = '<c-e>'

" run JSHint when a file with .js extension is saved
" this requires the jsHint2 plugin
"autocmd BufWritePost *.js silent :JSHint

" ---------------------- USER FUNCTIONS ----------------------

" Show syntax highlighting groups for word under cursor
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command! CHECKSYNTAX call SynStack()

"
" Turn On Auto Correct/Abbrevitions -- Auto Correct List(ACL)
func! ACLOn()
    if filereadable(expand('$HOME/.config/nvim/abbreviations/aclAbbrev.vim'))
      source $HOME/.config/nvim/abbreviations/aclAbbrev.vim
    endif
endfu

command! ACLON call ACLOn()

func! ACLOff()
    abclear
endfu

command! ACLOFF call ACLOff()

func! LangOn()
    ACLON
    " spelling and thesaurus
    setlocal spelllang=en_us
    setlocal spell 
    " set thesaurus+= <path to thesaurus file>
endfu

command! LANGON call LangOn()

func! LangOff()
    ACLOFF
    set nospell
endfu

command! LANGOFF call LangOff()

func! SpanishOn()
    " ACLON no ACL for spanish
    " spelling and thesaurus
    setlocal spelllang=es
    setlocal spell 
    " set thesaurus+= <path to thesaurus file>
endfu

command! SPANISH call SpanishOn()

func! SpanishOff()
    " ACLOFF no ACL for spanish
    set nospell
endfu

command! NOSPANISH call SpanishOff()

" Prose or Word Processor Mode
func! Prose()
    echo "Enter Prose/Word Processor Mode (user function)"
    " set file type to text so pandoc works
    setf pandoc
    " use pandoc and file type in place of vim-pencil
    "call pencil#init({'wrap': 'soft', 'autoformat': 0, 'textwidth': 82})
    "
    " Turn on language helpers
    call LangOn()
    " formatoptions
    " l	Long lines are not broken in insert mode: When a line was longer than
    "   'textwidth' when the insert command started, Vim does not
    "	automatically format it.
    setlocal formatoptions=l
    setlocal noexpandtab
    " j moves down a line, gj moves down one display line
    " similar with k and gk for up
    " vim-pencil/pandoc should take care of this, so comment it out
    "map j gj
    "map k gk
    " set complete+=s
    " use the par formatter
    " setlocal formatprg=par
    setlocal wrap
    setlocal linebreak

    " Turn on Goyo and set the width
    Goyo 120

    " Turn on Limelight
    "Limelight
endfu

" Turn off Prose mode
func! NoProse()
  echo "Exit Prose/Word Processor Mode (user function)"
  " re-detect file type 
  filetype detect
  " turn off language helpers
  call LangOff()
  setlocal formatoptions=tcqr
  " turn off Goyo
  Goyo!
endfu

" Turn on and off prose/word processing
command! WP call Prose() " Word Processing
command! NOWP call Prose() " Word Processing
command! PROSE call Prose()
command! NOPROSE call NoProse()

" Create PDF using vim-pandoc
" pdflatex and xelatex are two pdf engine choices.
  " -f markdown-raw_tex is for latex processing. Otherwise sometimes something
  "  like backslash (\) in text can cause errors.
func! PandocPdf()
  " Pandoc pdf --pdf-engine=pdflatex
  " Pandoc pdf --pdf-engine=pdflatex -f markdown-raw_tex
  " can use -V geometry:margin=1in for example if all margins are to be the same
  Pandoc pdf --pdf-engine=pdflatex -V geometry:"top=1.25in, bottom=1.0in, left=1.25in, right=1.00in"
endfu

func! PandocPdfNumbered()
  " The numbering uses filters: pandoc-secnos is part of the pandoc-xnos suite
  " I had some compatibility issue with pandoc-numbering, but pandoc-xnos seems to do what I need.
  " Pandoc pdf --pdf-engine=pdflatex -f markdown-raw_tex --number-sections --filter pandoc-xnos
  " can use -V geometry:margin=1in for example if all margins are to be the same
  Pandoc pdf --pdf-engine=pdflatex -V geometry:"top=1.25in, bottom=1.0in, left=1.25in, right=1.00in" --number-sections --filter pandoc-xnos
endfu

command! PDF call PandocPdf()
command! PDFNUM call PandocPdfNumbered()

" Make it easy to enable and disable LightLine
function! LightLineOn()
  set noshowmode
  call lightline#enable()
endfunction

function! LightLineOff()
  set showmode
  call lightline#disable()
endfunction

command! LIGHTLINE call LightLineOn()
command! LIGHTLINEOFF call LightLineOff()
command! NOLIGHTLINE call LightLineOff()


