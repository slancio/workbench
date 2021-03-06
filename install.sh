#!/bin/bash
# Install VIM & tmux configuration for local account

# Lock the script
if mkdir .workbenchlock
then

  # set up folder for backups
  WORKBENCHBACKUP=$(date +%Y%m%d%H%M%S)

  if [ ! -d ./backups ]
  then
    echo "Creating backups folder...\n"
    mkdir backups
  fi

  mkdir ./backups/$WORKBENCHBACKUP
  WORKBENCHLOG="./backups/${WORKBENCHBACKUP}/log.txt"
  printf "Installing workbench\n\n" > $WORKBENCHLOG

  # If tmux is installed, install .tmux.conf and backup existing one if present
  if [ -z ${TMUX+x} ]
  then
    printf "tmux not installed -- skipping .tmux.conf install\n" | tee -a $WORKBENCHLOG

  else
    if [ -f $HOME/.tmux.conf ]
    then
      printf ".tmux.conf file present -- moving to .tmux.conf.old\n" | tee -a $WORKBENCHLOG

      if [ -f $HOME/.tmux.conf.old ]
      then
        cp $HOME/.tmux.conf.old ./backups/$WORKBENCHBACKUP/.tmux.conf.older
        printf "...removed existing $HOME/.tmux.conf.old to ./backups/${WORKBENCHBACKUP}/.tmux.conf.older\n" | tee -a $WORKBENCHLOG
        rm -f $HOME/.tmux.conf.old
      fi

      mv $HOME/.tmux.conf $HOME/.tmux.conf.old
      printf "...moved to $HOME/.tmux.conf.old\n" | tee -a $WORKBENCHLOG
      cp $HOME/.tmux.conf.old ./backups/$WORKBENCHBACKUP
      printf "...copied to ./backups/${WORKBENCHBACKUP}\n" | tee -a $WORKBENCHLOG
    fi

    printf "tmux is present -- installing .tmux.conf\n\n" | tee -a $WORKBENCHLOG
    cp tmux.conf $HOME/.tmux.conf
  fi

  if [ -d $HOME/.vim ]
  then
    printf "$HOME/.vim exists -- moving to $HOME/.vim.old\n" | tee -a $WORKBENCHLOG

    if [ -d $HOME/.vim.old ]
    then
      cp -r $HOME/.vim.old ./backups/$WORKBENCHBACKUP/vim.older
      printf "...removed existing $HOME/.vim.old to ./backups/${WORKBENCHBACKUP}/.vim.older\n" | tee -a $WORKBENCHLOG
      rm -rf $HOME/.vim.old
    fi

    mv -f $HOME/.vim $HOME/.vim.old
    printf "...moved to $HOME/.vim.old\n" | tee -a $WORKBENCHLOG
    cp -r $HOME/.vim.old ./backups/$WORKBENCHBACKUP
    printf "...copied to ./backups/${WORKBENCHBACKUP}\n\n" | tee -a $WORKBENCHLOG
  fi

  if [ -f $HOME/.vimrc ]
  then
    printf "$HOME/.vimrc exists -- moving to $HOME/.vimrc.old\n" | tee -a $WORKBENCHLOG

    if [ -f $HOME/.vimrc.old ]
    then
      cp $HOME/.vimrc.old ./backups/$WORKBENCHBACKUP/.vimrc.older
      printf "...removed existing $HOME/.vimrc.old to ./backups/${WORKBENCHBACKUP}/.vimrc.older\n" | tee -a $WORKBENCHLOG
      rm -f $HOME/.vimrc.old
    fi

    mv $HOME/.vimrc $HOME/.vimrc.old
    printf "...moved to $HOME/.vimrc.old\n" | tee -a $WORKBENCHLOG
    cp $HOME/.vimrc.old ./backups/$WORKBENCHBACKUP
    printf "...copied to ./backups/${WORKBENCHBACKUP}\n\n" | tee -a $WORKBENCHLOG
  fi

  # install .vimrc
  printf "installing .vimrc\n" | tee -a $WORKBENCHLOG
  cp ./.vimrc $HOME/.vimrc

  # download Vundle
  printf "downloading Vundle\n" | tee -a $WORKBENCHLOG
  git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

  # build additioanl directories
  mkdir $HOME/.vim/colors

  # move theme to appropriate folder
  printf "\ninstalling vim themes\n" | tee -a $WORKBENCHLOG
  cp ./CandyPaper.vim $HOME/.vim/colors/

  # install Vundle plugins
  printf "installing vim plugins\n" | tee -a $WORKBENCHLOG
  vim +PluginInstall +qall

  # log directory tree of backed up files
  printf "\nContents of ./backups/${WORKBENCHBACKUP}\n" >> $WORKBENCHLOG
  ls -al ./backups/$WORKBENCHBACKUP/ >> $WORKBENCHLOG
  printf "\nWrote out log to ${WORKBENCHLOG}\n"

  printf "All done!\n"

  unset WORKBENCHBACKUP WORKBENCHLOG
else
  echo "VIOLATION: Lock .workbenchlock exists. Make sure this script is not running elsewhere and then remove .workbenchlock directory."
  exit 1
fi

rm -rf .workbenchlock
