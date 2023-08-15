{
  config,
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = lib.mkIf config.programs.helix.enable {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
  };

  imports = [
    ./languages.nix
    ./settings.nix
  ];

  nix.settings = lib.mkIf config.programs.helix.enable rec {
    substituters = trusted-substituters;
    trusted-substituters = [
      "https://helix.cachix.org"
    ];
    trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  programs.helix = {
    enable = true;
  };
}
