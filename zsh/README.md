## zsh

Aliases on this work repo all contain sensitive information (account data etc) as they pertain to my work. 
So this is not included in the dotfiles repo. 

Aliases are loaded by a simple if statement that checks if ~/.zsh/zshalias exists:

    if [ -f ~/.zsh/zshalias ]; then
        source ~/.zsh/zshalias
    else
        print "Uh oh: ~/.zsh/zshalias not found."
    fi

This allows me to manage multiple alias' across machines while keeping the same core zsh configuration.
You can add your aliases in this location as per normal.

If you are lazy:

    mkdir ~/.zsh && touch ~/.zsh/zshalias
