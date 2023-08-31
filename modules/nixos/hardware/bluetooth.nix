{
  lib,
  config,
  ...
}: {
  options.sys.hardware = {
    bluetooth = lib.mkEnableOption "System has a bluetooth adapter";
  };

  config = {
    hardware.bluetooth.enable = config.sys.hardware.bluetooth;
    services.blueman.enable = config.sys.hardware.bluetooth;
  };
}
