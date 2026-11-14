#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotconfig"

sudo pacman -Syu --needed --noconfirm git base-devel

if ! command -v yay &> /dev/null; then
    TMP_YAY=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$TMP_YAY"
    (cd "$TMP_YAY" && makepkg -si --noconfirm)
    rm -rf "$TMP_YAY"
fi

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone https://github.com/Daggersoath/dotconfig.git "$DOTFILES_DIR"
else
    git -C "$DOTFILES_DIR" pull
fi

mkdir -p "$HOME/.config"

CONFIGS=(alacritty cava dunst hypr pulse rofi starship.toml waybar wlogout ../.bashrc)
for cfg in "${CONFIGS[@]}"; do
    # Remove existing real directory if present (e.g., default hypr config) before linking
    if [ -d "$HOME/.config/$cfg" ] && [ ! -L "$HOME/.config/$cfg" ]; then
        rm -rf "$HOME/.config/$cfg"
    fi
    ln -sfn "$DOTFILES_DIR/configurations/$cfg" "$HOME/.config/$cfg"
done

if pacman -Qi jack2 &> /dev/null; then
    sudo pacman -Rdd --noconfirm jack2
fi

sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/pacman.pkg"
yay -S --needed --noconfirm - < "$DOTFILES_DIR/aur.pkg"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

mkdir -p "$HOME/.config/networkmanager-dmenu"
if [ ! -f "$HOME/.config/networkmanager-dmenu/config.ini" ] && [ -f /usr/share/doc/networkmanager-dmenu/config.ini.example ]; then
    cp /usr/share/doc/networkmanager-dmenu/config.ini.example "$HOME/.config/networkmanager-dmenu/config.ini"
fi

systemctl --user enable --now hyprpolkitagent.service
systemctl --user enable --now ssh-agent.service

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [ ! -f "$HOME/.ssh/config" ] || ! grep -q "AddKeysToAgent" "$HOME/.ssh/config"; then
    cat << 'EOF' >> "$HOME/.ssh/config"

Host *
    AddKeysToAgent yes
EOF
    chmod 600 "$HOME/.ssh/config"
fi

if ! gpg --list-secret-keys 2>/dev/null | grep -q "sec"; then
    echo "No GPG key found. Launching interactive GPG key generation..."
    gpg --full-gen-key
fi
