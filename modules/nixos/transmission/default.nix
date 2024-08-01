{pkgs, ...}: {
  services.transmission = rec {
    enable = true;
    package = pkgs.transmission_4-gtk;
    user = "cabero";
    home = "/home/${user}";
    settings.watch-dir = "${home}/Downloads";
  };
}
