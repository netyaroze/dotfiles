      ▓█████▄  ▒█████  ▄▄▄█████▓  █████▒██▓ ██▓    ▓█████   ██████
      ▒██▀ ██▌▒██▒  ██▒▓  ██▒ ▓▒▓██   ▒▓██▒▓██▒    ▓█   ▀ ▒██    ▒
      ░██   █▌▒██░  ██▒▒ ▓██░ ▒░▒████ ░▒██▒▒██░    ▒███   ░ ▓██▄
      ░▓█▄   ▌▒██   ██░░ ▓██▓ ░ ░▓█▒  ░░██░▒██░    ▒▓█  ▄   ▒   ██▒
      ░▒████▓ ░ ████▓▒░  ▒██▒ ░ ░▒█░   ░██░░██████▒░▒████▒▒██████▒▒
      ▒▒▓  ▒ ░ ▒░▒░▒░   ▒ ░░    ▒ ░   ░▓  ░ ▒░▓  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░
      ░ ▒  ▒   ░ ▒ ▒░     ░     ░      ▒ ░░ ░ ▒  ░ ░ ░  ░░ ░▒  ░ ░
      ░ ░  ░ ░ ░ ░ ▒    ░       ░ ░    ▒ ░  ░ ░      ░   ░  ░  ░
      ░        ░ ░                   ░      ░  ░   ░  ░      ░
       ░
 
 
### Hello
Uploaded for your horror is my personal dotfiles, both for my work and personal machines.

Each branch is labelled for each workstation. Most of the software is identical, however the themes differ.

1. **Work** - My work laptop, running Arch on the LTS kernel. Theme is heavily modified based on files provided by [u/sehnsuchtbsd](https://www.reddit.com/user/sehnsuchtbsd/) who's themes i heavily enjoy.
2. **Personal** - My personal laptop running Pop_OS! Dracula Theming is used (in some instances, dracula pro).
3. **Desktop** - Running Manjaro. Nord theme is used, however i am looking into alternatives. I will most likely move over to Tokyo-Night however there are not universal themes available for it that run in conjunction in a way that i'd like. 

Please see the install section on how to switch.

### Manage
This repo assumes you manage your dotfiles with [gnu stow](http://www.gnu.org/software/stow/) which is a lightweight symlink manager.  This repository allows me to keep a versioned history of my configuration files that are virtually linked with a single command, but it also makes sharing these files across machines (including mine, dare i format it). 

Stow is available for most distributions:
-   `sudo pacman -S stow`
-   `sudo apt-get install stow`
-   `brew install stow`

### To Install

Depending on which setup you are after, you will need to change to the appropriate branch:

    git clone https://github.com/netyaroze/dotfiles.git ~/
    cd ~/dotfiles
    git checkout work

My dotfiles setup assumes that this repository is cloned/located in the root of your home directory `~/dotfiles` . 
All commands pertaining to stow should be executed in that directory. 

The folder hierarchy of the repository is structured so that the folder structure is consistent with the configuration locations that lay above it (e.g ../dotfiles/.config). For example, running the following:

    stow i3

Will create a symlink as per the following:

    $ ls -lah ~/.config/ | grep i3
    lrwxrwxrwx 1 ntyze ntyze 25 Jul 16 13:48 /home/ntyze/.config/i3 -> ../dotfiles/i3/.config/i3

To uninstall the configuration:
	`stow -D i3`

**note:** stow will only create a symlink if a config file does not exist. If a default file was created upon program installation you must delete it first before you can install a new one with stow. This does not apply to directories, just files.

