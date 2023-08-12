{
  config,
  pkgs,
  ...
}:
with pkgs;
with lib;
with builtins; let
  cfg = config.sys;
in {
  options.sys.hardware.openrgb = mkEnableOption {
    default = false;
    description = "Whether to enable OpenRGB";
  };

  config = let
    enable = cfg.hardware.openrgb;
  in {
    environment.systemPackages = mkIf enable [openrgb i2c-tools];
    boot = mkIf enable {
      kernelParams = ["acpi_enforce_resources=lax"];
      kernelModules = ["i2c-dev"];
    };
    services.udev.extraRules = mkIf enable (readFile (fetchurl {
      url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage&inline=false";
    }));
    hardware.i2c.enable = enable;
  };
}
