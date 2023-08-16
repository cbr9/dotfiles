{pkgs, ...}: let
  bat = "${pkgs.bat}/bin/bat --decorations never --paging=never --color=always %pistol-filename%";
in {
  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "application/json";
        command = bat;
      }
      {
        mime = "text/*";
        command = bat;
      }
    ];
  };
}
