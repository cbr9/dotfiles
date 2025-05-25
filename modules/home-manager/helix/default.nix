{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.helix;
in {
  home.sessionVariables = mkIf cfg.enable rec {
    EDITOR = "${cfg.package}/bin/hx";
    VISUAL = EDITOR;
    SUDO_EDITOR = EDITOR;
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
      "application/json"
      "application/x-shellscript"
      "text/english"
      "text/html"
      "text/plain"
      "text/x-c"
      "text/x-c++"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-makefile"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
    ];
  };

  imports = [
    ./languages.nix
    ./settings.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.ruff
      pkgs.nil
      pkgs.nixfmt-rfc-style
    ];
  };
}
