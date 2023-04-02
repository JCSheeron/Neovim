
X11-Forwarding allows you to execute graphical programs on a remote SSH
host and display them locally.

If you're connecting to a remote SSH server for system administration
work, chances are you'll be running programs using sudo or su to switch
to another user such as root. You will get Can't open display, or X11
connection rejected because of wrong authentication error when running
GUI program in SSH when switching users via sudo or su.

    $ sudo xclock
	[sudo] password for user:
	X11 connection rejected because of wrong authentication.
	Error: Can't open display: localhost:10.0

This is because SSH X11-Forwarding requires authorization for connecting to
the X server which is stored in ~/.Xauthority file and with the correct
value for DISPLAY environment variable.

# Neovim Install Clipboard support

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

**Client**
In `/etc/ssh/ssh_config` or in `$HOME/.ssh/config`  need
`ForwardX11 yes` 

Need to install xauth tool:
`$ sudo apt install xauth`

# Steps to use SSH X11-Forwarding for sudo or su:

1. Make sure you're already able to run graphical program via SSH X tunneling as normal user.

2. Connect to SSH server with X11-Forwarding enabled.
	~$ ssh -X remote-host
	user@remote-host's password:
	Welcome to Ubuntu 20.10

	Last login: Sun Nov  1 21:17:13 2020 from 192.168.111.27

3. Get X authorization entry for current display.
	$ xauth list $DISPLAY
	host/unix:10  MIT-MAGIC-COOKIE-1  742d024faeb3d29a15ff06f1b8c3b21e

This info is stored in ~/.Xauthority file.

4. Get DISPLAY environment variable value.
	$ echo $DISPLAY
	localhost:10.0

5. Switch to root or other user using sudo and/or su.
	$ sudo su -
	[sudo] password for user:
	root@host:~# 

6. Generate ~/.Xauthority file using xauth add command.
	# xauth add host/unix:10  MIT-MAGIC-COOKIE-1 742d024faeb3d29a15ff06f1b8c3b21e

7. Check .Xauthority file to confirm.
	# cat ~/.Xauthority
	host10MIT-MAGIC-COOKIE-1t-O��Қ��ò 
	# xauth list $DISPLAY

8. Export DISPLAY environment variable value for current user
	# export DISPLAY=localhost:10.0

9. Run X program.
	# xclock
