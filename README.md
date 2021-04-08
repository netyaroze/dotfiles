# Dotfiles and Archlinux installation

## About
This project started out as a means to streamline both my work and personal laptops, which to be honest had become plagued with little nigs and nags. 
The repo was designed in a way where i could keep track of certain problems plagueing my desktop environment, and hopefully show the process of working these out.

**Background**: I have been using Pop!_OS for my work environment, however, i found it too bloated for what i actually required or really needed. Things like switching desktop environments
on Pop_OS had become cumbersome, and the documentation was quite sparse. I also found things like setting up fonts, font support etc tedious. The main reasons for using Pop!_OS had been
the hybrid graphics support, which both of my laptops use, and i would constantly run into issues on Arch (much to the irk of my own understanding). Using Hybrid graphics
is important for me because i tend to use it while docked. 

While some other distributions tend to have some of this working, i still find their theming ootb un-desirable and want to have control over my system from the ground up.
If you are considering the move to arch, i strongly recommend trying out installing arch yourself first or using a distro like endeavourOS (personally found this the nicest to use).
Having access to AUR and great documentation are solid reasons to move over to arch based system.

| Software | Name |
|--|--|
| Distribution | Arch Linux |
| Desktop environment | i3-gaps |
| Status bar | i3 status + conky |
| Application launcher | rofi |
| Terminal emulator | urxvt (true color fork with 256-bit color) |
| CLI interpreter | Zsh |
| Compositor | Picom |

A list of all installed packages can be found at: [pkglist.txt](https://github.com/netyaroze/dotfiles/blob/master/pkglist.txt)

## Getting started

1. **[Download Archlinux](https://www.archlinux.org/download/) and install it through the [installation guide](https://wiki.archlinux.org/index.php/installation_guide).**
```bash
#Make sure to download a boot manager and a connection manager
sudo pacman -S grub #or
sudo pacman -S refind #and follow the wiki to install it properly
sudo pacman -S networkmanager
systemctl enable NetworkManager
sudo pacman -S vim #Text editor
```
