{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs;
with lib; let
  cfg = config.sys.hardware;
in {
  options.sys.hardware = {
    cpu = mkOption {
      type = types.enum ["intel" "amd"];
      description = "Type of cpu the system has in it";
    };
    kvm = mkOption {
      type = types.bool;
      default = true;
      description = "Enable KVM virtualisation on this machine";
    };
  };
  config = {
    boot = {
      kernelParams = [
        (mkIf (cfg.cpu == "intel") "intel_pstate=active")
      ];

      kernelModules = [
        (mkIf cfg.kvm (mkIf (cfg.cpu == "amd") "kvm-amd"))
        (mkIf cfg.kvm (mkIf (cfg.cpu == "intel") "kvm-intel"))
      ];
    };

    environment.systemPackages = [
      (mkIf (cfg.cpu == "amd") microcodeAmd)
      (mkIf (cfg.cpu == "intel") microcodeIntel)
    ];

    virtualisation.libvirtd.enable = cfg.kvm;
  };
}
