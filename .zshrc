export ZSH=~/.oh-my-zsh

ZSH_THEME="maran"

plugins=(git)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# ------------------------------

# General Settings

# ------------------------------

export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定

export KCODE=u           # KCODEにUTF-8を設定


### Complement ###

autoload -U compinit; compinit # 補完機能を有効にする

setopt auto_list               # 補完候補を一覧で表示する(d)

setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)

setopt auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加

setopt mark_dirs               # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加

setopt list_types              # 補完候補一覧でファイルの種別を識別マーク表示

setopt complete_in_word        # 語の途中でもカーソル位置で補完

setopt always_last_prompt      # カーソル位置は保持したままファイル名一覧を順次その場で表示

setopt list_packed             # 補完候補をできるだけ詰めて表示する

setopt list_types              # 補完候補にファイルの種類も表示する

setopt globdots                # 明確なドットの指定なしで.から始まるファイルをマッチ

bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

zstyle ':completion:*' verbose yes

zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history



### History ###

HISTFILE=~/.zsh_history   # ヒストリを保存するファイル

HISTSIZE=10000            # メモリに保存されるヒストリの件数

SAVEHIST=10000            # 保存されるヒストリの件数

setopt bang_hist          # !を使ったヒストリ展開を行う(d)

setopt extended_history   # ヒストリに実行時間も保存する

setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない

setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する

setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する


# マッチしたコマンドのヒストリを表示できるようにする

autoload history-search-end

zle -N history-beginning-search-backward-end history-search-end

zle -N history-beginning-search-forward-end history-search-end

bindkey "^P" history-beginning-search-backward-end

bindkey "^N" history-beginning-search-forward-end



# すべてのヒストリを表示する

function history-all { history -E 1 }



# ------------------------------

# Look And Feel Settings

# ------------------------------



case "${OSTYPE}" in

darwin*)

  alias ls="ls -G"

  alias ll="ls -lG"

  alias la="ls -laG"

  export LS_COLORS='di=00;36'

  ;;


linux*)

  alias ls='ls --color'

  alias ll='ls -l --color'

  alias la='ls -la --color'

  export LS_COLORS='di=00;36'
  ;;

esac

# ------------------------------

# Alias

# ------------------------------

# cd->ls

chpwd() {

    ls_abbrev
}


ls_abbrev() {

    # -a : Do not ignore entries starting with ..

    # -C : Force multi-column output.

    # -F : Append indicator (one of */=>@|) to entries.

    local cmd_ls='ls'

    local -a opt_ls

    opt_ls=('-aCF' '--color=always')

    case "${OSTYPE}" in

        freebsd*|darwin*)

            if type gls > /dev/null 2>&1; then

                cmd_ls='gls'

            else

                # -G : Enable colorized output.

                opt_ls=('-aCFG')

            fi

            ;;

    esac

    local ls_result

    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')


    if [ $ls_lines -gt 10 ]; then

        echo "$ls_result" | head -n 5

        echo '...'

        echo "$ls_result" | tail -n 5

        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"

    else

        echo "$ls_result"

    fi

}

alias ll='ls -la'
alias unicorn:start='bundle exec rake unicorn:start'
alias unicorn:stop='bundle exec rake unicorn:stop'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
alias clip="nc localhost 8377"

#export PATH="$HOME/.phpenv/bin:$PATH"
# For PHP Environment
export PHP_ROOT="${HOME}/.phpenv"
if [ -d "${PHP_ROOT}" ]; then
   export PATH=${PHP_ROOT}/bin:$PATH
   eval "$(phpenv init -)"
fi
