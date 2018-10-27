rm -rf ~/.emacs* && mkdir {~/.emacs.d,~/.emacs.d/modules} && 
ln -s ~/emacs.d/init.el ~/.emacs.d/init.el || echo "Can not set up .emacs.d configuration!"
