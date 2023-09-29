{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    configFile.text =
      # nu
      ''
        $env.config = {
          show_banner: false,
          keybindings: [],
        }
      '';
  };
}
