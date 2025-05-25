{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./disks.nix
    ./openrgb.nix
    ./logitech.nix
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;

      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };

  };
}
