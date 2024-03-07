```diff 
@@  stuff to download  @@
```

Pacman Pkgs:
```diff
+(install)
alacritty
wezterm
qalculate-qt
python
ruby
rustup
lua
npm
xorg-xinit
xorg-server
xorg-xsel
ly
base-devel
lf
git
fzf
eza
htop
linux-headers
man-db
mpv
unclutter
fastfetch
ffmpeg
unzip
gzip
ripgrep
neovim
zsh
fish
wireplumber
playerctl
polybar
nvidia
nvidia-utils
nvidia-settings
firefox
qbittorrent
noto-fonts
noto-fonts-extra
noto-fonts-cjk
ttf-jetbrains-mono-nerd
ttf-nerd-fonts-symbols
ttf-nerd-fonts-symbols-common
ttf-ms-fonts
```
alternative install:
```
ghcup
qtile
qtile-extras
xmonad
xmonad-contrib
paru
eww
```

AUR Pkgs (paru):
```
awesome-luajit-git
picom-git
vscodium-bin
webcord-bin
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


