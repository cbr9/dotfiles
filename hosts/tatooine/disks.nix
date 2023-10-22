{
  disks ? ["/dev/nvme0n1"],
  lib,
  ...
}: {
  boot.loader.grub = {
    enable = lib.mkForce true;
    efiSupport = lib.mkForce true;
    efiInstallAsRemovable = lib.mkForce true;
    useOSProber = true;
    device = lib.mkForce "nodev";
  };

  disko.devices = {
    disk = {
      nvme0n1 = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
