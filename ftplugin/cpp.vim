" File ~/.vim/ftplugin/cpp.vim
"
" key mappings
"conflicts with vim-pandoc
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" cpp specific settings
setlocal textwidth=100
setlocal tabstop=2
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal formatoptions-=o

