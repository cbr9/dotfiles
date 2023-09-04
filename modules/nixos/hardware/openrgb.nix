{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.hardware.openrgb;
in
  with lib; {
    options = {
      services.hardware.openrgb = {
        extraArgs = lib.mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
    };

    config = lib.mkIf config.services.hardware.openrgb.enable {
      environment.systemPackages = [pkgs.i2c-tools];
      systemd.services.openrgb = {
        serviceConfig.ExecStart = lib.mkForce "${cfg.package}/bin/openrgb --server --server-port ${toString cfg.server.port} ${lib.concatStringsSep " " cfg.extraArgs}";
      };
    };
  }
