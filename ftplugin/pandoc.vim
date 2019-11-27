" File ~/.vim/ftplugin/pandoc.vim
"
" Vim-pandoc plugin will (usually/always/sometimes?) use markdown.vim or text.vim
" files first, so those settings don't need to be repeated here.
"
" key mappings
" Reformat paragraph
" commented out, as it is done in specific .vim files.
" noremap <buffer> Q gq}
"
" highlight a double space at the end of a line.
" Markdown interprets this as a line break.
" Not really needed, because Pandoc puts a <CR> symbol. Included here
" incase you don't like the default Pandoc behavior.
" highlight MarkdownTrailingSpaces ctermbg=green guibg=green
" syntax match MarkdownTrailingSpaces "\s\{2}$"

" turn off pandoc spell check favor of native vim spell check
let g:pandoc#spell#enabled=0
"turn on native spell check
" exclude acronyms (all upper case, at least 3 letters. 
" syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
setlocal spell spelllang=en_us


