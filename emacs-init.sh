#!/bin/bash

echo "Setting up emacs configurations ..."

CUR_PATH=$(pwd)

rm -rf {~/.emacs*,$CUR_PATH/tmp} && mkdir {~/.emacs.d,$CUR_PATH/tmp} &&
    ln -s $CUR_PATH/init.el ~/.emacs.d/init.el || echo "Can not set up .emacs.d configuration!"

# fetch org-mode repo
cd tmp && git clone https://github.com/tkf/org-mode.git && cd ..
    

