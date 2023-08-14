{nixosConfig, ...}: {
  imports = [
    ./package.nix
    ./bookmarks.nix
    ./search.nix
    ./extensions.nix
  ];

  programs.firefox = {
    enable = nixosConfig != {};
    profiles.default = {
      isDefault = true;
    };
  };
}
