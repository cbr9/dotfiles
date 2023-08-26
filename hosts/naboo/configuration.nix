{...}: {
  imports = [
    ../../modules/nixos/sony/specialisation.nix
  ];

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
  };
}
