{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      breeze-gtk
    ];
  };
}
