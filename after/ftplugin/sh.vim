" File ~/.vim/after/ftplugin/sh.vim
"
" key mappings

" sh specific settings

" prevent long lines from being split
setlocal textwidth=0
setlocal wrapmargin=0
setlocal linebreak

setlocal expandtab       " use spaces instead of tabs
setlocal autoindent      " autoindent based on line above, works most of the time
setlocal nosmartindent   " no smarter indent as in C-like languages
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=4    " when reading, tabs are 4 spaces
setlocal softtabstop=4   " in insert mode, tabs are 4 spaces
setlocal tabstop=4

" setlocal formatoptions-=o " do not auto insert comment leader

