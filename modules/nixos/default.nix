{pkgs, ...}: {
  imports = [
    ./1password
    ./asus-touchpad
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
    ./tailscale
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
      (agenix.packages.x86_64-linux.default.override {ageBin = "${pkgs.age}/bin/age";})
    ];
  };
}
