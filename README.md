```diff 
@@  stuff to download  @@
```

Pacman Pkgs:
```diff
+(install)
alacritty       
rustup
xorg-xinit
ly
base-devel
lf
git
fzf
eza             
unclutter        
fastfetch
neovim
zsh
wireplumber
playerctl
xbindkeys
nvidia-settings
firefox
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
eww
```

AUR Pkgs (paru):
```
awesome-git
picom-git
vscodium
intellij-idea-ultimate-edition-jre
intellij-idea-ultimate-edition
```


```diff 
@@  random fixes / config changes  @@
```
Edit /boot/loader/loader.conf
```diff
timeout 3
console-mode max
# console-mode keep
```
vscode go to settings search for ```"window.titleBarStyle": "native"``` and switch it to custom

go to /etc/enviroment and paste ```FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"```


