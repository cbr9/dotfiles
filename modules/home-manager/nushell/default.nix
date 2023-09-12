{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    configFile.text = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };
}
