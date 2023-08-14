{nixosConfig, ...}: {
  imports = [
    ./extensions.nix
    ./settings.nix
    ./bookmarks.nix
    ./search.nix
    ./package.nix
  ];

  programs.firefox = {
    enable = nixosConfig != {};
    profiles.default = {
      isDefault = true;
    };
  };
}
