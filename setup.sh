cd ~
sudo pacman -Syu --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

git clone https://github.com/Daggersoath/dotconfig.git
rm -rf ~/.config/hypr
rm ~/.bashrc

ln -s ~/dotconfig/.bashrc .bashrc
ln -s ~/dotconfig/.tmux .tmux
ln -s ~/dotconfig/.tmux.conf .tmux.conf

ln -s ~/dotconfig/configurations/alacritty .config/alacritty
ln -s ~/dotconfig/configurations/cava .config/cava
ln -s ~/dotconfig/configurations/dunst .config/dunst
ln -s ~/dotconfig/configurations/hypr .config/hypr
ln -s ~/dotconfig/configurations/pulse .config/pulse
ln -s ~/dotconfig/configurations/rofi .config/rofi
ln -s ~/dotconfig/configurations/starship.toml .config/starship.toml
ln -s ~/dotconfig/configurations/waybar .config/waybar
ln -s ~/dotconfig/configurations/wlogout .config/wlogout

sudo pacman -S --needed - < dotconfig/pacman.pkg
yay -S --needed - < dotconfig/aur.pkg

curl -sS https://starship.rs/install.sh | sh
curl -fsS https://dl.brave.com/install.sh | sh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

systemctl --user enable --now hyprpolkitagent.service
systemctl --user start hyprpolkitagent

gpg --full-gen-key

mkdir -p ~/.config/networkmanager-dmenu
cp /usr/share/doc/networkmanager-dmenu/config.ini.example ~/.config/networkmanager-dmenu/config.ini

sudo systemctl --user enable --now ssh-agent
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [ ! -f "$HOME/.ssh/config" ] || ! grep -q "AddKeysToAgent" "$HOME/.ssh/config"; then
    cat << 'EOF' >> "$HOME/.ssh/config"

Host *
    AddKeysToAgent yes
EOF
    chmod 600 "$HOME/.ssh/config"
fi
