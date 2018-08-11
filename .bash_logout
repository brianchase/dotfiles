# ~/.bash_logout

rm -f $HISTFILE && unset HISTFILE
[ -f "$HOME/.local/share/recently-used.xbel" ] && rm $HOME/.local/share/recently-used.xbel
[ -f "$HOME/.local/share/zathura/history" ] && rm -r $HOME/.local/share/zathura/history
[ -d "$HOME/.cache" ] && rm -r $HOME/.cache
[ -d "$HOME/.thumbnails" ] && rm -r $HOME/.thumbnails
