{...}: {
  config = {
    networking.vpn = ["tailscale"];

    sys = {
      users = ["cabero"];
      hardware = {
        cpu = "amd";
        gpu = "nvidia";
        bluetooth = true;
      };
    };

    services.xserver.desktopManager.gnome = {
      enable = true;
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
  };
}
