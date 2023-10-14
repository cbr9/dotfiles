{
  config,
  pkgs,
  ...
}: {
  config = {
    networking.vpn = ["tailscale"];
    sys = {
      users = ["cabero"];
      hardware = {
        isLaptop = true;
        cpu = "intel";
        gpu = "intel";
        bluetooth = true;
      };
    };

    services.hardware.openrgb = let
      red = "ff0000";
    in {
      enable = true;
      motherboard = "amd";
      extraArgs = [
        "--mode static"
        "--color ${red}"
      ];
    };

    services.thermald.enable = true;
    services.tlp.enable = true;
  };
}
