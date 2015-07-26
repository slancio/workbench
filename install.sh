#!/bin/bash
# Install VIM configuration for local account

# build directories
mkdir .vim
mkdir .vim/colors

# move theme to appropriate folder
mv ./CandyPaper.vim ./.vim/colors/

# download Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install Vundle plugins
#vim +PluginInstall +qall

echo "All done!\n"
