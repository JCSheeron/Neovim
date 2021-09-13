# Neovim
Neovim configuration related stuff, mostly init.vim
init.vim is usually in ~/.config/nvim, and is analogous to .vimrc

init_min.vim is a "minimum" init file that does not use plugins.

init_snvim.vim is like the minimum init file, but the main difference 
is that is is it is set not to make .orig files (set patchmode=.orig is not
specified). This is because this init file is used with the svim.sh script, which
controls the creation of the .orig file.

svim.sh is designed as an alternative to sudo vim cmd.  Put a link to this script
in a users bin file (e.g.: ~/bin) and then call svim <filename> to edit files as 
su.

The normal structure is
~~~~
~
 |__/.config
      |
      |__ nvim
	  |    |
	  |    |--init.vim
      |
      |    |__ /ftplugin
      |        |__ <filetype>.vim
	  |
	  |    |--/bundle   (plugins)
~~~~

