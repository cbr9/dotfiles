{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.networking.vpn = with types;
    mkOption {
      type = listOf (enum ["mullvad" "tailscale"]);
      default = [];
      description = "What VPN to use";
    };
  config = {
    networking.networkmanager.enable = true;
    services.mullvad-vpn.enable = builtins.elem "mullvad" config.networking.vpn;
    # add gui package
    environment.systemPackages = lib.optional (config.services.mullvad-vpn.enable) pkgs.mullvad-vpn;
  };
}
