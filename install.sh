#!/bin/bash -eu
echo "pwd: `dirname $0`"

pwd=`pwd`

GITCOMPLURL=https://raw.githubusercontent.com/git/git/master/contrib/completion

if [ ! -d tmp ]; then
	mkdir tmp
fi

ln -snf $pwd ~/.dotfiles

if [ ! -f ~/.git-completion.bash ]; then
	wget -N $GITCOMPLURL/git-prompt.sh -P tmp/
	wget -N $GITCOMPLURL/git-completion.bash -P tmp/
	ln -snf $pwd/tmp/git-prompt.sh ~/.git-prompt.sh
	ln -snf $pwd/tmp/git-completion.bash ~/.git-completion.bash
fi

ln -snf $pwd/.vimrc ~/.vimrc

ln -snf $pwd/.bash_profile ~/.bash_profile
#ls -la ~/.bash_profile

ln -snf $pwd/.bashrc ~/.bashrc
#ls -la ~/.bashrc.common

ln -snf $pwd/.tmux.conf ~/.tmux.conf
ln -snf $pwd/.tmux.osx.conf ~/.tmux.osx.conf
ln -snf $pwd/.tmux.linux.conf ~/.tmux.linux.conf
ln -snf $pwd/screenrc ~/.screenrc

mkdir -p ~/.vim/ftdetect
ln -snf $pwd/.vim/ftdetect/binary.vim ~/.vim/ftdetect/binary.vim

if [ ! -f ~/.vim/autoload/plug.vim ]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

ln -snf $pwd/alacritty.yml ~/.alacritty.yml
ls -la ~/.alacritty.yml

#TODO go,peco,ghq

echo "done."
