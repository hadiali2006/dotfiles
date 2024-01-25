```diff 
@@  stuff to download  @@
```

Pacman Pkgs:
```diff
!(ARCHINSTALLED)
alacritty       <- kitty or st better maybe
awesome
xorg-xinit
ly
networkmanager  <- needed for internet even wired idk why

+(install)
base-devel
lf
git
fzf
eza             <- consider lsd instead both are good
unclutter        
fastfetch
neovim
zsh
wireplumber
playerctl
xbindkeys
nvidia-settings
firefox
discord
qbittorrent
code
noto-fonts
noto-fonts-extra
noto-fonts-cjk
noto-fonts-emoji
ttf-jetbrains-mono-nerd
ttf-nerd-fonts-symbols
```
Build from src / clone:
```
paru
kickstart.nvim
```

AUR Pkgs (paru):
```
picom-git
vscodium
intellij-idea-ultimate-edition-jre
intellij-idea-ultimate-edition
```


```diff 
@@  random fixes / config changes  @@
```
(Soystemd/tty idk is wrong resolution fix) Edit /boot/loader/loader.conf
```diff
timeout 3
console-mode max
# console-mode keep
```
(visual soy code / visual soy codium titlebar color fix) go settings search for 
```"window.titleBarStyle": "native"``` and switch it to custom
better fonts maybe? im not sure if this does anything
go to /etc/enviroment and paste ```FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"```

