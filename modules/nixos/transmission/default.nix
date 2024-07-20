{...}: {
  services.transmission = rec {
    enable = true;
    user = "cabero";
    home = "/home/${user}";
    settings.watch-dir = "${home}/Downloads";
  };
}
