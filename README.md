![Maran Screenshot](https://raw.github.com/bamboo-yujiro/dotfiles/master/yujiro-sample.png "Maran ZSH theme")

At first, set your terminal profile to yujiro.terminal

# OSX
`$ brew install tmux`
`$ brew install reattach-to-user-namespace`
`$ cp .tmux.conf.osx .tmux.conf`


# Ubuntu
preparation

    $ sudo apt-get update
    $ sudo apt-get install git build-essential gettext

    $ git config --global user.email "ch11.naji@gmail.com"
    $ git config --global user.name "bamboo-yujiro"
    $ git config --global color.ui auto

install vim

    $ mkdir git && cd $_
    $ git clone https://github.com/vim-jp/vim.git
    $ cd vim
    $ sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev liblua5.2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev lua5.2
    $ ./configure --with-features=big --enable-luainterp=yes --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-lua-prefix=/usr --enable-gui=gnome2

    $ make
    $ sudo make install

install zsh

    $ sudo apt-get install zsh
    $ which zsh
    /usr/bin/zsh
    $ chsh -s /usr/bin/zsh

clone dotfiles

    $ curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    $ git clone https://github.com/bamboo-yujiro/dotfiles.git ~/dotfiles
    $ cat ~/dotfiles/maran.zsh-theme > ~/.oh-my-zsh/themes/maran.zsh-theme
    $ cd
    $ cd dotfiles
    $ git submodule init
    $ git submodule update
    $ ./setup.sh
    $ vim .vimrc
        ~ install plugin automatically
    $ exit

    〜 Login 〜


# CentOS

preparation

    $ git config --global user.email "ch11.naji@gmail.com"
    $ git config --global user.name "bamboo-yujiro"
    $ git config --global color.ui auto

install vim

    $ mkdir git && cd $_
    $ git clone https://github.com/vim-jp/vim.git
    $ cd vim
    $ sudo yum install ncurses-devel libgnome-devel libgnomeui-devel libnm-gtk-devel libbonoboui-devel libX11-devel libXpm-devel libXt-devel python-devel ruby-devel lua perl-ExtUtils-Embed
    $ make
    $ sudo make install

install zsh

    $ sudo apt-get install zsh
    $ which zsh
    /usr/bin/zsh
    $ sudo vi /etc/shells
       + /usr/bin/zsh
    $ sudo chsh -s /usr/bin/zsh [USER]


clone dotfiles

    $ curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    $ git clone https://github.com/bamboo-yujiro/dotfiles.git ~/dotfiles
    $ cat ~/dotfiles/maran.zsh-theme > ~/.oh-my-zsh/themes/maran.zsh-theme
    $ cd
    $ cd dotfiles
    $ git submodule init
    $ git submodule update
    $ ./setup.sh
    $ vim .vimrc
        ~ install plugin automatically
    $ exit

    〜 Login 〜
