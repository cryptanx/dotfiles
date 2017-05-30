# Completion Settings
setopt always_last_prompt       # 補完をしてもプロンプトの位置を変えない
setopt auto_list                # 補完候補が複数あるとき、自動でメニューをリストアップする
setopt auto_menu                # tab,^i で順次補完候補を補完
setopt auto_param_keys          # 変数名を補完する
setopt list_packed              # 補完候補を詰めて表示
setopt list_types               # 補完候補表示時にファイルの種類も表示する *, @, / などが付く
setopt auto_remove_slash        # ディレクトリの後でスペースを入力すると、ディレクトリの後ろに付くスラッシュを削除する
setopt auto_param_slash         # ディレクトリ名の補完で末尾に / を自動的に補完
setopt mark_dirs                # ファイル名展開でディレクトリにマッチすると / をつける
setopt complete_in_word         # 語の途中でもカーソル位置で補完
setopt magic_equal_subst        # --prefix=/usr などの = 以降も補完
setopt hist_verify              # ヒストリから呼び出したときに一度編集できるように
unsetopt list_beep              # 補完の時にベルを鳴らさない
unsetopt menu_complete          # 補完候補が複数ある時、すぐに最初の候補を補完する
unsetopt list_rows_first        # 補完の表示順序を水平方向にする
unsetopt complete_aliases       # エイリアスには別の補完規則を適用する
unsetopt correct_all            # 引数についてもスペル修正を試みる
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
# sudo も補完対象にする
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
setopt prompt_subst

## インクリメンタルに補完
# Ref http://d.hatena.ne.jp/seiunsky/20110519/1305764493
ENABLE_INCREMENTAL_COMPLETION=0
if [ $ENABLE_INCREMENTAL_COMPLETION = 1 ] ;
then
  source $HOME/.incr.zsh
fi

# Ignore completion on scp
zstyle ':completion:*:complete:scp:*:files' command command -

# Other Settings
bindkey -v
setopt multios                  # 複数リダイレクト有効
setopt auto_pushd               # cdの履歴を自動的に保存
setopt PUSHD_IGNORE_DUPS        # auto_pushd時に重複ディレクトリを無視
setopt auto_cd                  # ディレクトリ名のみのとき、自動的にcd

# History Settings
#<C-p>,<C-n>でコマンド履歴を戻る、進む
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

HISTFILE=~/.zsh_history          # コマンド履歴を保存するパス
HISTSIZE=100000                  # 保持する履歴の数
SAVEHIST=100000                  # 保存する最新の履歴の数
setopt bang_hist                 # !を使ったヒストリ展開を利用する
setopt extended_history          # 履歴に開始/終了時刻を記録
setopt inc_append_history        # 履歴をインクリメンタルに追加
setopt hist_ignore_dups          # 同じコマンドを連続して実行したとき、1つしか記録しない
setopt hist_ignore_space         # スペースから始まるものはヒストリに追加しない
setopt hist_reduce_blanks        # ヒストリ記録時に余分なスペースを削除する
setopt hist_no_store             # history コマンドは記録しない
setopt append_history            # zsh 複数起動時 history ファイルを上書きせず追記
setopt share_history             # 複数のzshセッションでヒストリをリアルタイムで共有する
unsetopt hist_ignore_all_dups    # ヒストリ内に全く同じ行があれば、古い方を削除する
unsetopt hist_expire_dups_first  # 古いヒストリが削除されるとき、まったく同じ行があれば、それを削除する
unsetopt hist_save_no_dups       # ヒストリ記録時に、古いコマンドと同じものがあれば削除する

#auto ls
function chpwd() { ls -ah }

# cd .. with ^^
function cdup(){
  echo
  cd ..
  zle reset-prompt
 }
 zle -N cdup
 bindkey '\^\^' cdup

# Autojump settings
PATH=$HOME/.autojump/bin:$PATH
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

# show vcs branch info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%r)-[%b]'
zstyle ':vcs_info:*' actionformats '(%r)-[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# Color Settings
autoload -U colors
colors

#RPROMPT="%1(v|%F{blue}%1v%f|)"
# ログイン名
#  <- Ctrl + v + esc 
# %{[38;5;38m%} <- color setting
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
#PROMPT='[%F%{[38;5;38m%}%n%f@%F%{[38;5;208m%}%U%m%u%f:%d]# '
PROMPT='[%F%{[38;5;38m%}%m%f@%F%{[38;5;208m%}%U(oゝω･o)ﾉ☆ﾟ.*･｡ﾟ%u%f:%d]# '

#PROMPT='[%F{magenta}%B%n%b%f@%F{blue}%U%m%u%f:%d]# '
PROMPT+='$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


# Show current directory on Finder
function showFinder(){
  open `pwd`
}
zle -N showFinder
bindkey '^f' showFinder

# Environment Variable Settings
export PATH=/usr/local/share/npm/bin:/usr/texbin:$HOME/.bin:/usr/local/bin:/Applications/Android/sdk/platform-tools:$HOME/Library/Haskell/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export EDITOR=/usr/local/bin/vim
export SDL_VIDEODRIVER=X11

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

## ls
#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias gls="gls --color"
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias -s txt=less
alias -s rb=ruby
alias -s pl=perl
alias ls="ls -a -G -l -h"
alias rm="rm -i"

#zsh syntax highlighting
if [ -f ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#for Python Development
PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

alias brew="env PATH=${PATH/\/Users\/khtmtvx\/\.pyenv\/shims:/} brew"

#for Ruby Development
PATH=$HOME/.rbenv/bin:$PATH
PATH=$HOME/.rbenv/shims:$PATH # Add rbenv to PATH

#for Node Development
if [[ -f ~/.nodebrew/nodebrew ]]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

#Setting for hub
# hub alias -s zsh
alias git=hub
if type compdef >/dev/null; then
   compdef hub=git
fi

# setup perlbrew
if [ -f "~/perl5" ];
then
  source ~/perl5/perlbrew/etc/bashrc
fi

# for Android
NDK_ROOT=/Applications/Android/sdk
ANDROID_SDK_ROOT_LOCAL=/Applications/Android/sdk

#Settings for tmux-powerline
PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

fpath=(/usr/local/share/zsh/site-functions/ ${fpath})
autoload -U compinit; compinit -u  # zshの補完機能を利用する

# MacVimをターミナルで使う
#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

# colordiff
if [[ -x `which colordiff` ]]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

PATH=$HOME/.vim/latex:$PATH


case ${OSTYPE} in 
    linux*)
        alias ls="ls -a -G -l --color"
        ;;
esac

## virtualenv, virtualenvwrapper
which virtualenvwrapper.sh > /dev/null
if [ $? -eq 0 ]; then
#    source `which virtualenvwrapper.sh`
    mkdir -p ~/.virtualenvs
    export WORKON_HOME=~/.virtualenvs
    export PIP_RESPECT_VIRTUALENV=true
fi

#export PATH=/usr/local/bin:/usr/bin


#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#fi

alias vim="nvim"
alias tmux="tmux -2"
alias pbcopy="xsel --clipboard --input"

export PATH=~/.local/bin:$PATH  
