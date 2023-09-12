{...}: {
  imports = [
    ../../modules/nixos/sony/specialisation.nix
  ];

  config = {
    networking.vpn = ["mullvad" "tailscale"];
    sys = {
      users = ["cabero"];
      hardware = {
        isLaptop = true;
        cpu = "intel";
        gpu = "intel";
        bluetooth = true;
      };
    };
  };
}
