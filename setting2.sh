#!/bin/sh

user_name="yujiro"
git_user_email="ch11.naji@gmail.com"
git_username="bamboo-yujiro"

export ZSH="/home/${user_name}/.oh-my-zsh"
export ~="/home/${user_name}"

#apt-get update

apt-get install -y git build-essential gettext

git config --global user.email "${git_user_email}"

git config --global user.name "${git_username}"

git config --global color.ui auto

<<<C
if [ ! -e /home/${user_name}/git ]; then
  mkdir /home/${user_name}/git
fi

cd /home/${user_name}/git

git clone https://github.com/vim-jp/vim.git

cd vim

apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev liblua5.2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev lua5.2

./configure --with-features=big --enable-luainterp=yes --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-lua-prefix=/usr --enable-gui=gnome2

make

make install

apt-get install -y zsh

if [ ! -e /home/${user_name}/.oh-my-zsh ]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  chsh -s /bin/bash
fi

chsh -s /usr/bin/zsh ${user_name}

cat /home/${user_name}/dotfiles/maran.zsh-theme > /home/${user_name}/.oh-my-zsh/themes/maran.zsh-theme

cd /home/${user_name}/dotfiles/

git submodule init

git submodule update

for dotfile in .vim .vimrc .zshrc .tmux.conf
do
  rm -fr /home/${user_name}/$dotfile
  ln -vnfs /home/${user_name}/dotfiles/$dotfile /home/${user_name}/$dotfile
done

chown -R ${user_name}:${user_name} /home/${user_name}/

su ${user_name}

vi +":NeoBundleInstall" +:q

exit
C
