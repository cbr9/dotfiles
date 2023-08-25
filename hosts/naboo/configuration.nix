{...}: {
  imports = [
    ../../modules/nixos/sony/specialisation.nix
  ];

  config = {
    networking.vpn = ["tailscale" "mullvad"];

    security.pam.yubico = {
      enable = true;
      debug = false;
      mode = "challenge-response";
      id = ["15582547" "15582531"];
    };

    services.pcscd.enable = true;

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
