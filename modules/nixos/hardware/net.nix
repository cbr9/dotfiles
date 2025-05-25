{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  services.mullvad-vpn = {
    enable = false;
    package = pkgs.mullvad-vpn;
  };
}
