# Paths (also using ~/.profile)
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# Path to oh-my-zsh installation.
export ZSH="/home/ntyze/.oh-my-zsh"
export TERM=xterm-256color

# Themes
ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

# Just update me up fam.
DISABLE_UPDATE_PROMPT="true"

# Fat Finger Mode
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

# Source oh-my-zsh.
source $ZSH/oh-my-zsh.sh

# additional user man config location
export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases on this work repo all contain sensitive information (account data etc) as they pertain to my work.
# So this is not included in the dotfiles repo. All aliases should be added to the zshalias file as you would here.
# It's also just better to manage tbh.
if [ -f ~/.zsh/zshalias ]; then
    source ~/.zsh/zshalias
else
    print "Uh oh: ~/.zsh/zshalias not found."
fi

# Persistent Aliases
alias vi3='vim ~/.config/i3/config'
alias viz='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias xmerge='xrdb --merge ~/.Xresources'
alias code='vscodium &'

# Syntax Highlighting
source /home/ntyze/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi
