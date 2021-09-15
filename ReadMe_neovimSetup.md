# Install Neovim

- It may be in the distribution repository ...
	sudo apt-get install neovim
- Or maybe it isn't already in one of the repositories ...
Add the neovim repository:
	sudo add-apt-repository ppa:neovim-ppa/stable  (or .../unstable)
	sudo apt-get update
	sudo apt-get install neovim

## Install Python support
- Install Python for Python based modules
 
	sudo apt-get install python-dev python-pip python3-dev python3-pip

- Install pynvim module (this python module used to be called neovim)

- Needs wheel and setup tools
 
	python -m pip install --user wheel
	python3 -m pip install --user wheel
	python -m pip install --user setuptools
	python3 -m pip install --user setuptools

	python -m pip install --user --upgrade pynvim
	python2 -m pip install --user --upgrade pynvim
	python3 -m pip install --user --upgrade pynvim

## Weird Characters on Command Line
If you get weird characters, this is usually a terminal that is not able to show *fancy* cursors/characters.
Upgrade the terminal or change the cursor (not sure how on the later)
Here is what I did to update Guake (build it from the lateset from github):
- Make a directory to hold the source. Clone the source
`git clone https://github.com/Guake/guake.git 3.6.3`
- Run the script to install the dependencies
`./scripts/bootstrap-dev-debian.sh run make`
- Install guake
`make`
`sudo make install`
- To uninstall
`make`
`sudo uninstall`

### Update/Install Guake

- Clone from GitHub: `git clone https://github.com/Guake/guake.git <tag>`
- Get any dependencies: `./scripts/bootstrap-dev-[debian, arch, fedora].sh run make`

# Configure NeoVim
- Default configuration goes in a text file: ~/.config/nvim/init.vim
- One I made can be found in GitHub: https://github.com/JCSheeron/Neovim.git. Note
this uses plugins and vim-plug which is not yet installed.
* Get init_min.vim from git for a minimum config.
* Get the snvim.sh script and the init_snvim.vim from git. Make a link to snvim.share
in a user bin folder e.g.~/bin:
	`ln -s /home/username/.config/nvim/snvim.sh /home/username/bin/svim `

## Install Plugins

- Install vim-plug
 
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

- Run nvim. You'll get plug in related errors if init.vim references plugins.
- From within vim, run vim-plug to install the plugins: `:PlugInstall`
- Note: denite plugin requires python 3.6+, so :checkhealh will show errors if 
this reqirement isn't met.

### CoC Plugin
- Coc requires nodejs.  If nodejs is not installed, neovim should work, but CoC will
give an error on startup before opening a buffer, and on the status line once
a buffer is opened.
- To install nodejs
(assuming ubuntu or Debian, but may vary with OS)
Using Ubuntu
`curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -`
`sudo apt-get install -y nodejs`

Using Debian, as root
`curl -fsSL https://deb.nodesource.com/setup_16.x | bash -`
`apt-get install -y nodejs`

# Check Health

- Check NeoVim status/health with:
`:checkhealth`

## Install Clipboard support

- Run :checkhealth within NeoVim. If there is a error/warning about no
clipboard support or no clipboard provider, there are several provider
options, but two are xclip or xsel. 
Install xsel:
'sudo apt-get install xsel'
Install xclip:
`sudo apt-get install xclip`

# Make Veovim the default editor
sudo update-alternatives --config vi
sudo update-alternatives --config vim
sudo update-alternatives --config editor


