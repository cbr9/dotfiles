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
          system.nixos.tags = ["sony"];
          networking.vpn = lib.mkForce [];
          sony = {
            enable = true;
            user = "decabera";
            server = "destc0strapp15";
            key = "/home/cabero/.ssh/id_ed25519";
          };
        };
      };

      virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
        enableNvidia = true;
      };

      networking = {
        vpn = ["tailscale" "mullvad"];
        hostName = "naboo";
      };

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
