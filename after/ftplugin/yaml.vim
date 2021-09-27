" File ~/.vim/after/ftplugin/yaml.vim
"
" key mappings

setlocal textwidth=100

setlocal expandtab       " use spaces instead of tabs
setlocal autoindent      " autoindent based on line above, works most of the time
setlocal smartindent     " smarter indent for C-like languages
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=2    " when reading, tabs are 4 spaces
setlocal softtabstop=2   " in insert mode, tabs are 4 spaces
setlocal tabstop=2

setlocal formatoptions-=o " do not auto insert comment leader


" Use the below highlight group when displaying bad whitespace is desired.
" Display tabs at the beginning of a line in Yaml mode as bad.
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/


