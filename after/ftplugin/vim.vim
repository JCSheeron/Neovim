" File ~/.vim/after/ftplugin/vim.vim
"
" vim specific settings

setlocal expandtab       " use spaces instead of tabs
setlocal autoindent      " autoindent based on line above, works most of the time
setlocal smartindent     " smarter indent for C-like languages
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=2    " when reading, tabs are 4 spaces
setlocal softtabstop=2   " in insert mode, tabs are 4 spaces
setlocal tabstop=2

setlocal formatoptions-=o " do not auto insert comment leader

