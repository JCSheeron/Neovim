" File ~/.vim/after/ftplugin/yaml.vim
"
" key mappings

setlocal textwidth=100
setlocal tabstop=2
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
" prevents insertion of '*' at the beginning of every line in a comment
setlocal formatoptions-=o

" Use the below highlight group when displaying bad whitespace is desired.
" Display tabs at the beginning of a line in Yaml mode as bad.
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/


