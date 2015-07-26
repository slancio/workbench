#!/bin/bash
# Install VIM & tmux configuration for local account

# If tmux is installed, install .tmux.conf and backup existing one if present
if [ -z ${TMUX+x} ]
then
  echo "tmux not installed -- skipping .tmux.conf install"
else
  if [ -f $HOME/.tmux.conf ]
  then
    echo ".tmux.conf file present -- moving to .tmux.conf.old"
    mv $HOME/.tmux.conf $HOME/.tmux.conf.old

    echo "...installing .tmux.conf"
    cp tmux.conf $HOME/.tmux.conf
  else
    echo "tmux is present -- installing .tmux.conf"
    cp tmux.conf $HOME/.tmux.con
  fi  
fi

if [ -d $HOME/.vim ]
then
  echo "$HOME/.vim exists -- moving to $HOME/.vim.old"
  mv $HOME/.vim $HOME/.vim.old
fi

if [ -f $HOME/.vimrc ]
then
  echo "$HOME/.vimrc exists -- moving to $HOME/.vimrc.old"
  mv $HOME/.vimrc $HOME/.vimrc.old
fi

# install .vimrc
echo "installing .vimrc"
cp ./.vimrc $HOME/.vimrc

# download Vundle
echo "downloading Vundle"
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# build additioanl directories
mkdir $HOME/.vim/colors

# move theme to appropriate folder
echo "installing vim themes"
cp ./CandyPaper.vim $HOME/.vim/colors/

# install Vundle plugins
echo "installing vim plugins"
vim +PluginInstall +qall

echo "All done!"

