{
  lib,
  config,
  ...
}:
with lib; {
  programs.lazygit = {
    enable = true;
    settings = {os = {editPreset = "helix";};};
  };
  programs.fish.shellAbbrs = mkIf config.programs.lazygit.enable {
    lg = "lazygit";
  };
}
