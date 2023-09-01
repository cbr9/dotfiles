{
  config,
  pkgs,
  lib,
  ...
}: let
  autoStart = flags:
    pkgs.writeScriptBin "rgb" ''
      #!/bin/sh
      ${pkgs.openrgb}/bin/openrgb ${lib.concatStringsSep " " flags}
    '';

  cfg = config.services.hardware.openrgb;
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
