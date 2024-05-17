{pkgs, ...}: {
  imports = [
    ./1password
    ./awesome
    ./base
    ./bash
    ./betterlockscreen
    ./clipmenu
    ./fish
    ./fonts
    ./gtk
    ./hardware
    ./kdeconnect
    ./mysql
    ./nix
    ./nix-index
    ./nushell
    ./openrgb
    ./picom
    ./qt
    ./sshfs
    ./stylix
    ./spotify
  ];

  environment = {
    systemPackages = with pkgs; [
      killall
      git
      wget
      autorandr
      openssl
      libnotify
      pkg-config
      xclip
      pavucontrol
    ];
  };

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
}
