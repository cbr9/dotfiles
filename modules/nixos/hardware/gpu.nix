{
  pkgs,
  lib,
  config,
  ...
}:
with pkgs;
with lib;
with builtins; {
  options.sys.hardware = {
    gpu = with types;
      mkOption {
        type = nullOr (enum ["amd" "intel" "nvidia"]);
        default = "none";
        description = "The primary GPU of your system";
      };
  };
  options.sys.graphics = {
    desktopProtocols = mkOption {
      type = types.nullOr (types.listOf (types.enum ["xorg" "wayland"]));
      default = ["xorg"];
    };

    displayManager = mkOption {
      type = types.enum ["none" "lightdm" "gdm"];
      default = "lightdm";
    };

    windowManager = mkOption {
      type = types.enum ["i3"];
      default = "i3";
    };

    v4l2loopback = mkEnableOption "Enable v4l2loop back on this system";
  };

  config = let
    amd = config.sys.hardware.gpu == "amd";
    intel = config.sys.hardware.gpu == "intel";
    nvidia = config.sys.hardware.gpu == "nvidia";
    xorg = elem "xorg" config.sys.graphics.desktopProtocols;
    desktopMode = config.sys.graphics.desktopProtocols != null;
    headless = config.sys.hardware.gpu == null;
    kernelPackage = config.boot.kernelPackages;
  in {
    boot = {
      initrd.kernelModules = [
        (mkIf amd "amdgpu")
      ];
      extraModprobeConfig = mkIf config.sys.graphics.v4l2loopback ''
        options v4l2loopback exclusive_caps=1 video_nr=9 card_label="obs"
      '';

      extraModulePackages = [
        (mkIf config.sys.graphics.v4l2loopback kernelPackage.v4l2loopback)
      ];
    };

    services.xserver = mkIf xorg {
      enable = true;
      videoDrivers = [
        (mkIf amd "amdgpu")
        (mkIf intel "intel")
        (mkIf nvidia "nvidia")
      ];

      deviceSection = mkIf (intel || amd) ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';

      displayManager = {
        lightdm = {
          enable = config.sys.graphics.displayManager == "lightdm";
          background = lib.mkForce config.stylix.image;
          greeters.gtk.enable = true;
        };
        gdm = {
          enable = config.sys.graphics.displayManager == "gdm";
          wayland = config.sys.graphics.displayManager == "gdm";
        };
      };

      libinput = {
        enable = true;
        touchpad = lib.mkIf (config.sys.hardware.isLaptop) {
          naturalScrolling = true;
          disableWhileTyping = true;
        };
      };
    };

    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        forceFullCompositionPipeline = true;
        powerManagement.enable = true;
      };
      opengl = {
        enable = !headless;
        driSupport = !headless;
        driSupport32Bit = !headless;
        extraPackages = mkIf (!headless) (with pkgs; [
          (mkIf amd amdvlk)
          (mkIf intel intel-media-driver)
          (mkIf intel vaapiIntel)
          (mkIf intel vaapiVdpau)
          (mkIf intel libvdpau-va-gl)
          libva
        ]);
        extraPackages32 = mkIf (!headless) (with pkgs.driversi686Linux; [
          (mkIf amd amdvlk)
          (mkIf intel vaapiIntel)
        ]);
      };
    };

    environment.systemPackages = with pkgs; [
      (mkIf desktopMode vulkan-tools)
      (mkIf desktopMode vulkan-loader)
      (mkIf desktopMode vulkan-headers)
      (mkIf desktopMode glxinfo)
      (mkIf amd radeontop)
      (mkIf intel libva-utils)
      (mkIf config.sys.graphics.v4l2loopback kernelPackage.v4l2loopback)
      (mkIf config.sys.graphics.v4l2loopback libv4l)
      (mkIf config.sys.graphics.v4l2loopback xawtv)
      (mkIf desktopMode ueberzug)
      (mkIf desktopMode dfeet)
    ];

    services.autorandr.enable = xorg;
  };
}
