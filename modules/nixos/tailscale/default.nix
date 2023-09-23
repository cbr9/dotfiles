{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (builtins.elem "tailscale" config.networking.vpn) {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };

    networking.firewall = {
      # enable the firewall
      enable = true;

      # always allow traffic from your Tailscale network
      trustedInterfaces = ["${config.services.tailscale.interfaceName}"];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [config.services.tailscale.port];

      # allow you to SSH in over the public internet
      allowedTCPPorts = [22];
    };
  };
}
