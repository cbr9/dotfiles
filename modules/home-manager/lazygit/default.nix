{...}: {
  programs.lazygit = {
    enable = true;
    settings = {os = {editPreset = "helix";};};
  };
}
