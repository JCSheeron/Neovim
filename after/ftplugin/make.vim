" File ~/.vim/after/ftplugin/make.vim
"
" make specific settings
setlocal textwidth=85

setlocal expandtab       " use spaces instead of tabs
setlocal autoindent      " autoindent based on line above, works most of the time
setlocal smartindent     " smarter indent for C-like languages
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=4    " when reading, tabs are 4 spaces
setlocal softtabstop=4   " in insert mode, tabs are 4 spaces
setlocal tabstop=4

setlocal formatoptions-=o " do not auto insert comment leader

