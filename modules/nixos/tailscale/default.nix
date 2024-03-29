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
        type = types.path;
        default = null;
      };
      operator = mkOption {
        type = types.str;
        default = null;
      };
    };
  };

  config = {
    age.secrets = {
      tailscale.file = ../../../secrets/tailscale.age;
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
      taildropDir = "${config.home-manager.users.cabero.home.homeDirectory}/Downloads";
      operator = "cabero";
      extraUpFlags = [
        "--operator=${cfg.operator}"
        "--exit-node=de-fra-wg-403.mullvad.ts.net"
        "--exit-node-allow-lan-access=true"
      ];
      authKeyFile = config.age.secrets.tailscale.path;
    };

    home-manager.users.cabero = {
      programs.fish.shellAbbrs = {
        taildrop = "tailscale file";
        tailsend = "tailscale file cp";
        tailget = "tailscale file get";
      };
    };

    systemd.services.taildrop = {
      description = "Run taildrop in a loop";
      after = ["tailscaled.service"];
      wants = ["tailscaled.service"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/tailscale file get --conflict rename --verbose --loop ${cfg.taildropDir}";
      };
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
