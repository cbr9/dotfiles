{pkgs, ...}: {
  imports = [
    ./1password
    ./asus-touchpad
    ./base
    ./bash
    ./fish
    ./fonts
    ./gnome
    ./gtk
    ./hardware
    ./i3
    ./i3status-rust
    ./kdeconnect
    ./nix
    ./nix-index
    ./nushell
    ./picom
    ./qt
    ./sony
    ./sshfs
    ./tailscale
    ./thefuck
    ./zsh
  ];

  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks # is the package manager for Lua modules
      luadbi-mysql # Database abstraction layer
    ];
  };
}
