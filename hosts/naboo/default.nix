{...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disks.nix
    ./openrgb.nix
    ./logitech.nix
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
