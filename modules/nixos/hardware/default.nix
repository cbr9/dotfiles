{
  lib,
  config,
  ...
}: {
  options.sys.hardware = with lib; {
    isLaptop = lib.mkOption {
      type = types.bool;
      default = false;
    };
  };

  imports = [
    ./cpu.nix
    ./gpu.nix
    ./audio.nix
    ./disk.nix
    ./bluetooth.nix
    ./net.nix
    ./openrgb.nix
  ];

  config = {
    programs.light.enable = config.sys.hardware.isLaptop;
    services.logind = {
      lidSwitch = "hibernate";
      lidSwitchDocked = "hibernate";
      lidSwitchExternalPower = "hibernate";
      powerKey = "hibernate";
      powerKeyLongPress = "hibernate";
    };
  };
}
