DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DIR=$(pwd)
sudo pacman -S --needed yay tree 
yay -S --needed vim plasma-workspace-agent-ssh libdbusmenu-glib appmenu-gtk-module jetbrains-toolbox webtorrent-desktop-bin qalculate-gtk oxygen-sounds plasma-browser-integration sierrabreeze-kwin-decoration-git zsh plasma5-applets-window-appmenu plasma5-applets-window-buttons plasma5-applets-window-title libreoffice-fresh bluez-utils bluez-hciconfig go latte-dock-git kvantum-qt5 libguestfs rust nextcloud zoxide fzf ripgrep ripgrep-all hyperfine tokei docker fd-git bat exa procs-git texlive-full libappindicator-gtk2 libappindicator-gtk3 kernel-modules-hook
sudo systemctl daemon-reload
sudo systemctl enable linux-modules-cleanup
#curl -L https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh | sh
#conda update --prefix $HOME/.anaconda3 anaconda
cp $DIR/.zshrc $HOME
cp .alacritty.yml $HOME

cargo install cargo-watch cargo-edit cargo-update amber
#sudo cp $DIR/environment /etc/
#sudo cp $DIR/kcmfonts $HOME/.config/kcmfonts
sudo chsh cabero -s /usr/bin/zsh
reboot
