# dotfiles

## REQUIREMENT
* PICOM

if you using arch linux 
``` bash
sudo pacman -S picom
```
* KITTY
``` bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```
* i3WM
```bash
sudo pacman -S i3-wm
```

* NEOVIM

``` BASH
sudo pacman -S neovim
```

* STARSHIP
``` bash
curl -sS https://starship.rs/install.sh | sh
```

* POLYBAR
``` bash
sudo pacman -S polybar
```

* STOW
``` bash
sudo pacman -S stow 
```

### when all done. then you need to run this inside dotfiles directory
``` bash
stow .
```
