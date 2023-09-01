{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.hardware.openrgb;
  autoStart = flags:
    pkgs.writeScriptBin "rgb" ''
      #!/bin/sh
      ${cfg.package}/bin/openrgb ${lib.concatStringsSep " " flags}
    '';
in
  with lib; {
    options = {
      services.hardware.openrgb = {
        autoStartFlags = lib.mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
    };

    config = lib.mkIf config.services.hardware.openrgb.enable {
      systemd.services.rgb = lib.mkIf (cfg.autoStartFlags != []) {
        description = "rgb";
        serviceConfig = {
          ExecStart = "${(autoStart cfg.autoStartFlags)}/bin/rgb";
          Type = "oneshot";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  }
