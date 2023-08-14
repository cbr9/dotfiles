{
  pkgs,
  nixosConfig,
  ...
}: {
  programs.firefox = {
    enable = nixosConfig != {};
    package = import ./package.nix {inherit pkgs nixosConfig;};
    profiles.default = {
      isDefault = true;
      bookmarks = import ./bookmarks.nix;
      settings = import ./settings.nix;
      search = import ./search.nix {inherit pkgs;};
      extensions = import ./extensions.nix {inherit nixosConfig;};
    };
  };
}
