DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DIR=$(pwd)
sudo pacman-mirrors --api --set-branch unstable
sudo pacman-mirrors --fasttrack 5 && sudo pacman -Syyu
sudo pacman -S yay tree mlocate qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables
yay -S vim plasma-workspace-agent-ssh libdbusmenu-glib appmenu-gtk-module jetbrains-toolbox webtorrent-desktop-bin qalculate-gtk oxygen-sounds plasma-browser-integration sierrabreeze-kwin-decoration-git zsh oh-my-zsh-git plasma5-applets-window-appmenu plasma5-applets-window-buttons plasma5-applets-window-title libreoffice-fresh bluez-utils bluez-hciconfig go latte-dock kvantum-qt5 libguestfs rust nextcloud zoxide fzf ripgrep ripgrep-all hyperfine tokei docker fd-git bat exa procs-git neovim
curl -L https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh | sh
conda update --prefix $HOME/.anaconda3 anaconda
sudo cp $DIR/.zshrc $HOME/
sudo cp $DIR/environment /etc/
sudo cp $DIR/kcmfonts $HOME/.config/kcmfonts
sudo chsh cabero -s /usr/bin/zsh
reboot
