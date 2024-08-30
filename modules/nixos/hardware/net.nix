{pkgs, ...}: {
  networking.networkmanager.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
