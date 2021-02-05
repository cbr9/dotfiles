DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DIR=$(pwd)

# INSTALL RUST
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# INSTALL RUST BINARIES
cargo install cargo-watch cargo-edit cargo-update cargo-expand cargo-audir cargo-bloat sd paru sd starship topgrade ripgrep ripgrep_all cargo-spellcheck cargo-outdated hyperfine tokei fd bat exa procs zoxide alacritty

paru -S --needed vim plasma-workspace-agent-ssh libdbusmenu-glib appmenu-gtk-module jetbrains-toolbox oxygen-sounds plasma-browser-integration zsh plasma5-applets-window-appmenu plasma5-applets-window-buttons plasma5-applets-window-title libreoffice-fresh bluez-utils bluez-hciconfig go latte-dock-git kvantum-qt5 libguestfs rustup nextcloud fzf docker texlive-full libappindicator-gtk2 libappindicator-gtk3 kernel-modules-hook
sudo systemctl daemon-reload
sudo systemctl enable linux-modules-cleanup
#curl -L https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh | sh
#conda update --prefix $HOME/.anaconda3 anaconda
cp $DIR/.zshrc $HOME
cp .alacritty.yml $HOME

#sudo cp $DIR/environment /etc/
#sudo cp $DIR/kcmfonts $HOME/.config/kcmfonts
sudo chsh cabero -s /usr/bin/zsh
reboot
