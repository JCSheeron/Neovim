# vim
vim related stuff, mostly .vimrc

The normal structure is
~~~~
~
 |__/.vim
      |
      |__ vimrc   (notice no . at the beginning)
      |
      |__ /ftplugin
          |__ <filetype>.vim
~~~~

And then the ~/.vimrc file is a symbolic link
to ~/.vim/vimrc.  As an alternative, ~/.vim/vimrc could be move to ~.
It is instead in ~/.vim so it is easier to manage, having all the vim
customizations together, and the symbolic link is used so it can also
show up in ~, as expected.
