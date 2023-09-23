{...}: {
  imports = [
    ../../modules/nixos/sony/specialisation.nix
  ];

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
  };
}
