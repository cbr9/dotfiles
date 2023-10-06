{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.carapace = {
    enable = false;
    enableNushellIntegration = false;
  };
  home.packages = with pkgs;
    lib.mkIf config.programs.carapace.enable [
      gh
      glab
    ];
}
