sudo pacman -Syu --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

git clone https://github.com/Daggersoath/dotconfig.git
rm -rf .config/hypr/hyprland.conf
rm .bashrc

ln -s dotconfig/.bashrc .bashrc
ln -s dotconfig/.tmux .tmux
ln -s dotconfig/.tmux.conf .tmux.conf

ln -s dotconfig/configurations/alacritty .config/alacritty
ln -s dotconfig/configurations/cava .config/cava
ln -s dotconfig/configurations/dunst .config/dunst
ln -s dotconfig/configurations/hypr .config/hypr
ln -s dotconfig/configurations/pulse .config/pulse
ln -s dotconfig/configurations/rofi .config/rofi
ln -s dotconfig/configurations/starship.toml .config/starship.toml
ln -s dotconfig/configurations/waybar .config/waybar
ln -s dotconfig/configurations/wlogout .config/wlogout

sudo pacman -Syu alacritty cava dunst rofi waybar firefox ttf-fira-code fastfetch cifs-utils keepass noto-fonts-cjk ttf-jetbrains-mono-nerd otf-font-awesome pavucontrol less tmux 
curl -sS https://starship.rs/install.sh | sh
curl -fsS https://dl.brave.com/install.sh | sh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo pacman -Syu hyprpolkitagent
systemctl --user enable --now hyprpolkitagent.service
systemctl --user start hyprpolkitagent

yay -Syu hyprshot

gpg --full-gen-key

yay -Syu plex-desktop discord_arch_electron discord-canary
