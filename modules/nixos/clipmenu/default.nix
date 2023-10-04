{...}: {
  services.clipmenu = {
    enable = true;
  };
  environment.sessionVariables = {
    CM_LAUNCHER = "rofi";
  };
}
