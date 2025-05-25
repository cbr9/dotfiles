{
  lib,
  config,
  ...
}:
{
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
  ];

  config = {
    hardware.enableAllFirmware = true;
    programs.light.enable = config.sys.hardware.isLaptop;
    services.logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "suspend";
      powerKeyLongPress = "suspend";
    };
  };
}
