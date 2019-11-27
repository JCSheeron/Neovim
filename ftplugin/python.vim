" File ~/.vim/ftplugin/python.vim
"
" key mappings
"conflicts with vim-pandoc
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Python specific settings
setlocal textwidth=100
setlocal tabstop=4
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=4
setlocal softtabstop=4
" prevents insertion of '*' at the beginning of every line in a comment
setlocal formatoptions-=o

" Use the below highlight group when displaying bad whitespace is desired.
" Display tabs at the beginning of a line in Python mode as bad.
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/


