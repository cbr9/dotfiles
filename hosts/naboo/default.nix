{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
    ./openrgb.nix
    ./logitech.nix
  ];
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
