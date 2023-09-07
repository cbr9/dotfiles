{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.helix;
in {
  home.sessionVariables = mkIf cfg.enable {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
  };

  xdg.desktopEntries.Helix = lib.mkIf (cfg.enable && (builtins.hasAttr "TERMINAL" config.home.sessionVariables)) {
    name = "Helix";
    genericName = "Helix";
    type = "Application";
    exec = "${config.home.sessionVariables.TERMINAL} -e ${cfg.package}/bin/hx %F";
    icon = "helix";
    startupNotify = false;
    terminal = false;
    categories = ["Utility" "TextEditor"];
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "application/json"
      "text/x-c"
      "text/x-c++"
    ];
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
