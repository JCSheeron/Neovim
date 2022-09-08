" File ~/.vim/after/ftplugin/python.vim
"
" key mappings

" Python specific settings
setlocal colorcolumn=79,99
setlocal textwidth=99

setlocal expandtab       " use spaces instead of tabs
setlocal autoindent      " autoindent based on line above, works most of the time
setlocal smartindent     " smarter indent for C-like languages
" default to 4 tabs.  
setlocal shiftwidth=4    " when reading, t:helpabs are 4 spaces
setlocal softtabstop=4   " in insert mode, tabs are 4 spaces
setlocal tabstop=4

setlocal formatoptions-=o " do not auto insert comment leader

" Use the below highlight group when displaying bad whitespace is desired.
" Display tabs at the beginning of a line in Python mode as bad.
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/


