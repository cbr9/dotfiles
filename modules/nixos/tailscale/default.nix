{
  config,
  lib,
  ...
}: let
  cfg = config.services.tailscale;
in {
  options = with lib; {
    services.tailscale = {
      taildropDir = mkOption {
        type = types.nullOr types.path;
        default = null;
      };
      operator = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
  config = lib.mkIf (builtins.elem "tailscale" config.networking.vpn) {
    age.secrets = {
      tailscale.file = ../../../secrets/tailscale.age;
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
      taildropDir = "${config.home-manager.users.cabero.home.homeDirectory}/Downloads";
      operator = "cabero";
      extraUpFlags = (
        [
          "--exit-node=de-fra-wg-403.mullvad.ts.net"
          "--exit-node-allow-lan-access=true"
        ]
        ++ lib.optional (cfg.operator != null) "--operator=${cfg.operator}"
      );
      authKeyFile = config.age.secrets.tailscale.path;
    };

    systemd.user.services.taildrop-receive = lib.mkIf (cfg.enable && cfg.taildropDir != null) {
      wantedBy = ["default.target"];
      script = ''
        ${cfg.package}/bin/tailscale file get --conflict rename --verbose --loop ${cfg.taildropDir}
      '';
    };

    networking.firewall = {
      # enable the firewall
      enable = true;

      # always allow traffic from your Tailscale network
      trustedInterfaces = ["${cfg.interfaceName}"];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [cfg.port];

      # allow you to SSH in over the public internet
      allowedTCPPorts = [22];
    };
  };
}
