{
  pkgs,
  config,
  nixosConfig,
  ...
}: {
  imports = [
    ./bookmarks.nix
    ./search.nix
    ./extensions.nix
    ./settings.nix
  ];

  programs.firefox = {
    enable = nixosConfig != {};
    package = pkgs.firefox.override {
      cfg = {
        enableGnomeExtensions = nixosConfig.services.xserver.desktopManager.gnome.enable;
        enableTridactylNative = builtins.elem nixosConfig.nur.repos.rycee.firefox-addons.tridactyl config.programs.firefox.profiles.default.extensions;
      };
      extraPolicies = import ./policies.nix {inherit config;};
    };
    profiles.default = {
      isDefault = true;
    };
  };
}
