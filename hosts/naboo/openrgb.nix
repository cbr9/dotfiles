{...}: {
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    extraArgs = [
      "--mode off"
    ];
  };
}
