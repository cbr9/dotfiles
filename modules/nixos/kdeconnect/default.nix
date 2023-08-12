{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  headless = config.sys.graphics.desktopProtocols == null;
in {
  config = mkIf (!headless) {
    programs.kdeconnect.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
