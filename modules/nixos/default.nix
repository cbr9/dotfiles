{pkgs, ...}: {
  imports = [
    ./1password
    ./awesome
    ./transmission
    ./spotify
    ./base
    ./bash
    ./betterlockscreen
    ./clipmenu
    ./fish
    ./fonts
    ./hardware
    ./kdeconnect
    ./nix
    ./nushell
    ./openrgb
    ./picom
    ./stylix
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
}
