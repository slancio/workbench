#!/bin/bash
# Install VIM configuration for local account

if [ $(pwd) == $HOME ]
then
  # download Vundle
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # build directories
  mkdir .vim/colors

  # move theme to appropriate folder
  mv ./CandyPaper.vim ./.vim/colors/

  # install Vundle plugins
  #vim +PluginInstall +qall

  echo "All done!\n"
else
  echo "This script and the files contained in the package must be run out of your $HOME directory"       
fi

