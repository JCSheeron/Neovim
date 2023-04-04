# Install Neovim

- It may be in the distribution repository ...
	sudo apt-get install neovim
- Or maybe it isn't already in one of the repositories ...
Add the neovim repository:

	sudo add-apt-repository ppa:neovim-ppa/stable  (or .../unstable)
	sudo apt-get update
	sudo apt-get install neovim
	
OR Build from source
TODO

## Install Python support
- Install Python for Python based modules
 
	sudo apt-get install python-dev python-pip python3-dev python3-pip

- Install pynvim module (this python module used to be called neovim)
- 
	pip2 install pynvim
	pip3 install pynvim

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
	git clone https://github.com/Guake/guake.git 3.6.3
- Run the script to install the dependencies
	./scripts/bootstrap-dev-debian.sh run make
- Install guake
 
	make
	sudo make install
	
- To uninstall

	make
	sudo uninstall

### Update/Install Guake

- Clone from GitHub: `git clone https://github.com/Guake/guake.git <tag>`
- Get any dependencies: `./scripts/bootstrap-dev-[debian, arch, fedora].sh run make`

# Configure NeoVim
- Default configuration goes in a text file: `~/.config/nvim/init.vim`
- One I made can be found in GitHub: `https://github.com/JCSheeron/Neovim.git`. Note
this uses plugins and vim-plug which is not yet installed.
* Get init_min.vim from git for a minimum config.
* Get the snvim.sh script and the init_snvim.vim from git. Make a link to snvim.share
in a user bin folder e.g.~/bin:

	`ln -s /home/username/.config/nvim/snvim.sh /home/username/bin/svim `

## Install Plugins

- Install vim-plug
 
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

- Run nvim. You'll get plug in related errors if init.vim references plugins.
- call plug#begin('~/.config/nvim/bundle/') in init.vim to begin plugin config/install area
- call plug#end() in init.vim after plugin config/install

- From within vim, run vim-plug to install the plugins: `:PlugInstall`
- Note: denite plugin requires python 3.6+, so :checkhealh will show errors if 
this reqirement isn't met.

### Node JS and CoC Plugin
- Coc requires nodejs.  If nodejs is not installed, neovim should work, but CoC will
give an error on startup before opening a buffer, and on the status line once
a buffer is opened.

#### Install Node with NVM (recommended)
- You can install node via nvm (node version manager). This seems to be smooth.
Github:
    
    https://github.com/nvm-sh/nvm
    
Substitue most recent version in the below command to install nvm:
    
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    
Running the above curl command downloads a script and runs it.  The script clones the nvm repository to `~/.nvm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bash_profile`, `~/.zshrc`, `~/.profile`, or `~/.bashrc`).

See more details on github page above.

Source .bashrc or restart terminal

To verify that nvm has been installed, do:
    
    command -v nvm

To download, compile, and install the latest release of node, do this:

    nvm install node # "node" is an alias for the latest version

To install a specific version of node:

    nvm install 14.7.0 # or 16.3.0, 12.22.1, etc

#### Install NodeJs Manually
- To install nodejs
(assuming ubuntu or Debian, but may vary with OS)
Using Ubuntu

    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs

Using Debian, as root

    curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
    apt-get install -y nodejs

Also, use npm to install the Node.js provider (optional)

    sudo npm install -g neovim
    
Also, the bash language server (for coc-sh and other plugins and coc extensions)

    sudo npm i -g bash-language-server
    
Once node is installed and CoC is installed, CoC will run the installation of the extensions once Neovim is opened.
# Check Health

- Check NeoVim status/health with:
`:checkhealth`

## Install Clipboard support

- Run :checkhealth within NeoVim. If there is a error/warning about no
clipboard support or no clipboard provider, there are several provider
options, but two are xclip or xsel. 
Install xsel:

	sudo apt-get install xsel
	
Install xclip:

sudo apt-get install xclip

Need X11 Forwarding on server and client.
**Server**
In `/etc/ssh/sshd_config` 
`X11Forwarding yes` 
*Might* need `X11UseLocalhost no`

Need to install xauth tool:
`$ sudo apt install xauth`

**Client**
In `/etc/ssh/ssh_config` or in `$HOME/.ssh/config`  need
`ForwardX11 yes` 


# Make Veovim the default editor
	select-editor
	
	sudo update-alternatives --config vi
	sudo update-alternatives --config vim
	sudo update-alternatives --config editor
	
OR   

	sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
	sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
	sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 60
	
# Pandoc Support and PDF Creation
vim-pandoc is a plugin, but for the pdf engine can be tricky to get working.  I am using pdflated, but one way I 
have gotten it to work (there may be others) is to install (`sudo apt install texlive-latex-extra`). See README.Debian
in /usr/share/doc/pandoc. It states `texlive-latex-recommended` should work, but I have had better luck with `...-extra`.

## Pandoc Numbering

For PDF numbering, needed to install pandoc-secnos at a minimum.  It is part of the pandoc-xnos filter suite.  I installed pandoc-xnos instead:

	pip install pandoc-fignos pandoc-eqnos pandoc-tablenos pandoc-secnos --user

and then in usage in the pandoc command use:
	
	--filter pandoc-xnos

Note that in the pandoc-xnos documentation, it says that any use of `pandoc-citeproc` or `--bibliography=FILE` should come after the `pandoc-xnos` filter call.

# Setup svim
Usage: Use the script `svim <file>` as an alternative to `sudo vim <file>`. It manages .orig files better, 
and has its own look and nvim configuration.

I created a bash script (`svim.sh`) and a vim initialization file (`init_snvim.vim`) that work together to
* Use Vim for sudo editing
* Create a separate config (without all the plugins) for sudo editing. It was thought looking different and
having the ability to have a different config while editing would be a good thing.
* Manage the creation of .orig files.

The `svim.sh` script and the `init_snvim.vim` file are already in the  neovim repo.

**One additional step:** It is easiest to use if you create a link to this script in a path that is already in the `$PATH` variable e.g.:
`ln -s $HOME/.config/nvim/svim.sh $HOME/.config/bin/svim` (note I left the .sh off the link, so usage should be `svim <file>` from anywhere once this link is in the path.
