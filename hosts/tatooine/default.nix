{
  pkgs,
  inputs,
  ...
}:
with pkgs;
  lib.mkHost {
    inherit pkgs inputs;

    configuration = {
      specialisation = {
        sony.configuration = {
          networking.vpn = lib.mkForce [];
          sony = {
            enable = true;
            user = "decabera";
            server = "destc0strapp15";
            key = "/home/cabero/.ssh/id_rsa";
          };
        };
      };

      networking = {
        vpn = ["tailscale" "mullvad"];
        hostName = "tatooine";
      };
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
