{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.caffeine;
in {
  services.caffeine.enable = true;
  home.packages = lib.mkIf cfg.enable [pkgs.caffeine-ng];
  systemd.user.services.caffeine = lib.mkIf cfg.enable (lib.mkForce {
    Unit = {Description = "caffeine";};

    Install = {WantedBy = ["graphical-session.target"];};

    Service = {
      Restart = "on-failure";
      Type = "exec";
      Slice = "session.slice";
      ExecStart = "${pkgs.caffeine-ng}/bin/caffeine";
    };
  });
}
