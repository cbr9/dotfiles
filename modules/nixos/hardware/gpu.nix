{pkgs, ...}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    dpi = 125;
    libinput.enable = true;
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
      powerManagement.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.libva
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    d-spy
    glxinfo
    vulkan-headers
    vulkan-loader
    vulkan-tools
    xawtv
  ];
}
