{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.carapace = {
    enable = true;
    enableNushellIntegration = false;
  };
  home.packages = with pkgs;
    lib.mkIf config.programs.carapace.enable [
      gh
      glab
    ];
}
