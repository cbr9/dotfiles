{...}: {
  imports = [
    ../../modules/nixos/sony/specialisation.nix
  ];

  config = let
    red = "ff0000";
  in {
    networking.vpn = ["tailscale" "mullvad"];

    sys = {
      users = ["cabero"];
      hardware = {
        cpu = "amd";
        gpu = "nvidia";
        bluetooth = true;
      };
    };

    services.hardware.openrgb = {
      enable = true;
      motherboard = "amd";
      autoStartFlags = [
        "--mode static"
        "--color ${red}"
      ];
    };
  };
}
