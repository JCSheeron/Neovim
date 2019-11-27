" File ~/.vim/ftplugin/markdown.vim
"
" key mappings
" Reformat paragraph
" may conflict with Ycm user map of <leader>g for goto definition
noremap <buffer> Q gq}

" highlight a double space at the end of a line.
" Markdown interprets this as a line break.
" When using pandoc, this will get overridden by pandoc, so if it is wanted, 
" put something similar in .vim/ftplugin/pandoc.vim
highlight MarkdownTrailingSpaces ctermbg=green guibg=green
syntax match MarkdownTrailingSpaces "\s\{2}$"

" text specific settings
setlocal colorcolumn=80
setlocal textwidth=82
setlocal tabstop=4
" For the amount of space used for a new tab use shiftwidth.
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal noexpandtab
" use the par formatter
"setlocal formatprg=par
setlocal wrap
setlocal linebreak

" Format options
"set formatoptions=tcqrn1
"tcq is default
setlocal formatoptions=tcqrl
"setlocal formatoptiddons-=o
"setlocal formatoptions+=l

" Turn off settings in 'formatoptions' relating to comment formatting.
" - t : Auto-wrap text using textwidth
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - q :	Allow formatting of comments with 'gq'.
"	    Note that formatting will not change blank lines or lines containing
"   	only the comment leader.  A new paragraph starts after such a line,
"	    or when the comment leader changes.
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" l	Long lines are not broken in insert mode: When a line was longer than
"   'textwidth' when the insert command started, Vim does not
"	automatically format it.

" j moves down a line, gj moves down one display line
" similar with k and gk for up
" comment out so they don't interfere with other buffers
" Also, these are taken care of by vim-pencil/pandoc
" map j gj
" map k gk
"
"
" spelling and thesaurus
" exclude acronyms (all upper case, at least 3 letters. 
"syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
setlocal spell spelllang=en_us

" set thesaurus+= <path to thesaurus file>
" set complete+=s

"load auto corrections (Auto Complete List ACL) as abbreviations
if filereadable(expand('$HOME/.vim/abbreviations/aclAbbrev.vim'))
  source $HOME/.vim/abbreviations/aclAbbrev.vim
endif


