# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="$HOME/.emacs.d/bin:$PATH"
#export PATH=$PATH:/usr/local/go/bin

# Path to your oh-my-zsh installation.
export ZSH="/home/netyaroze/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="netduellj"

# Opts
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"

# History Opts
setopt    appendhistory   
setopt    sharehistory    
setopt    incappendhistory 

# Standard plugins $ZSH/plugins/
# Custom plugins $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# tmux on load
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#      tmux attach -t default || tmux new -s default
#fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Persistent Aliases
alias vi3='vim ~/.config/i3/config'
alias viz='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias xmerge='xrdb -merge ~/.Xresources'
alias ls='lsd'
alias fwupdate='sudo fwupdmgr update'

# GoLang
export GOROOT=/home/netyaroze/.go
export PATH=$GOROOT/bin:$PATH
export PATH=~/node_modules/.bin:$PATH
source /home/netyaroze/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
