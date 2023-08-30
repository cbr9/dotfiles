{
  lib,
  config,
  ...
}: {
  options.sys.hardware = {
    bluetooth = lib.mkEnableOption "System has a bluetooth adapter";
  };

  config = {
    hardware.bluetooth.enable = config.hardware.bluetooth;
    services.blueman.enable = config.hardware.bluetooth;
  };
}
