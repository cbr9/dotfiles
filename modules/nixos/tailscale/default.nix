{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (builtins.elem "tailscale" config.networking.vpn) {
    environment.systemPackages = [pkgs.tailscale];

    services.tailscale.enable = true;
    networking.nftables = lib.mkIf config.services.mullvad-vpn.enable {
      enable = true;
      ruleset = ''
        define RESOLVER_ADDRS = {
            100.100.100.100
        }

        define EXCLUDED_IPS = {
            100.66.240.134,
            100.97.92.41
        }

        # Comment the following block if you do not want IPv6 support.
        define EXCLUDED_IPV6 = {
            fd7a:115c:a1e0:ab12:4843:cd96:6261:5c29,
            fd7a:115c:a1e0:ab12:4843:cd96:6242:f086
        }

        table inet mullvad-ts {
          chain excludeOutgoing {
            type route hook output priority 0; policy accept;
            ip daddr $EXCLUDED_IPS ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            # Comment the following line if you do not want IPv6 support.
            ip6 daddr $EXCLUDED_IPV6 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }

          chain allow-incoming {
            type filter hook input priority -100; policy accept;
            iifname ${config.services.tailscale.interfaceName} ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }

          chain excludeDns {
            type filter hook output priority -10; policy accept;
            ip daddr $RESOLVER_ADDRS udp dport 53 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            ip daddr $RESOLVER_ADDRS tcp dport 53 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }
        }
      '';
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
