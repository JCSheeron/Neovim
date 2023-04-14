#!/usr/bin/env bash
# Batch file open a file in vim using 'sudo vim'.
# If the specified file exists:
#   If a file with the same name with '.orig' appended does not exist,
#   a copy of the specified file is created with '.orig' appended to the
#   file name is created. To prevent accidental deletion, this file will
#   be marked as read only, and the immutable flag will be set.
#
#   The file is then opened with sudo vim <filename>
#
#   If a file with the same name with '.orig' appended already exists,
#   no copy is made, and the file is opened with sudo vim <filename>
#
# If the specified file does not exist:
#   No copy is made, and the file is opened with sudo vim <filename>
#
# vim is started with a special config file in init_snvim.vim if it exists. 
# This config has the .orig patchmode feature turned off so this script can
# control the .orig file making.
# 
# If init_snvim.vim does not exist, then init_min.vim will be used. If that
# does not exist, vim will be started with vim -u NONE

function usage {
    echo "svim <filename>"
}

FILE=$1
ORIGFILE="$FILE.orig"
CFGFILE="$HOME/.config/nvim/init_snvim.vim"
ALTCFG="$HOME/.config/nvim/init_min.vim"

if [ -f "$FILE" ] && [ ! -f "$ORIGFILE" ]; then
    # the file exists, but the orig copy does not.
    # Create the orig copy. Make it read only, root owned, 
    # and set the immutable flag to prevent deletion.
    echo "Making File $ORIGFILE"
    sudo rsync -a "$FILE" "$ORIGFILE"
    sudo chown root:root "$ORIGFILE"
    sudo chmod a-w "$ORIGFILE"
    sudo chattr +i "$ORIGFILE"
fi

# enable xauthority with the sudo user
# by settign up xauthority and .Xauthority file for root.
# An alternative may be to copy the users .Xauthority file over
# to root.
if [ -f "$HOME/.Xauthority" ]; then
    # prepare to set the display and xauthority vars in the root env
    # the xauthority to XAUTHORITY or ~/.Xauthority
    xa="${XAUTHORITY-$HOME/.Xauthority}"
    # a brute force hack to the above and below use of vars is:
    # sudo cp $HOME/.Xauthority /root/.Xauthority
fi

# See which cfg file to use
if [ -f "$CFGFILE" ]; then
    echo "Using vim config file: $CFGFILE"
    # sudo "$xd" nvim -u "$CFGFILE" "$FILE"
    sudo DISPLAY="$DISPLAY" XAUTHORITY="$xa" nvim -u "$CFGFILE" "$FILE"
elif [ -f "$ALTCFG" ]; then
    echo "Using vim config file: $ALTCFG"
    #sudo "$xd" nvim -u "$ALTCFG" "$FILE"
    sudo DISPLAY="$DISPLAY" XAUTHORITY="$xa" nvim -u "$ALTCFG" "$FILE"
else
    echo "No vim config file found. Not using one"
    sudo DISPLAY="$DISPLAY" XAUTHORITY="$xa" nvim -u NONE "$FILE"
fi

