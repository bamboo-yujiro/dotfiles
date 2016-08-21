#!/bin/sh
user_name="yujiro"
export ZSH="/home/${user_name}/.oh-my-zsh"

apt-get update

apt-get install -y git build-essential gettext

git config --global user.email "ch11.naji@gmail.com"

git config --global user.name "bamboo-yujiro"

git config --global color.ui auto

mkdir /home/$user_name/git && cd $_

git clone https://github.com/vim-jp/vim.git

cd vim

apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev liblua5.2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev lua5.2

./configure --with-features=big --enable-luainterp=yes --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-lua-prefix=/usr --enable-gui=gnome2

make

make install

apt-get install -y zsh

chsh -s /usr/bin/zsh ${user_name}

if [ ! -e /home/${user_name}/.oh-my-zsh ]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

git clone https://github.com/bamboo-yujiro/dotfiles.git /home/${user_name}/dotfiles

cat /home/${user_name}/dotfiles/maran.zsh-theme > /home/${user_name}/.oh-my-zsh/themes/maran.zsh-theme

cd /home/${user_name}/dotfiles/

git submodule init

git submodule update

for dotfile in .vim .vimrc .zshrc .tmux.conf
do
  rm -fr /home/${user_name}/$dotfile
  #ln -vnfs $PWD/$dotfile ~/$dotfile
  ln -vnfs /home/${user_name}/dotfiles/$dotfile /home/${user_name}/$dotfile
done

chown ${user_name}:${user_name} /home/${user_name}/

su ${user_name}

vi +":NeoBundleInstall" +:q

exit
