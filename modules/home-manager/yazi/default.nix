{...}: {
  imports = [
    ./plugins
    ./settings.nix
    ./keymap.nix
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };
}
