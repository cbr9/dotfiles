{
  pkgs,
  config,
  nixosConfig,
  lib,
  ...
}: {
  imports = [
    ./bookmarks.nix
    ./search.nix
    ./extensions.nix
    ./settings.nix
  ];

  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };
  home.packages = lib.mkIf config.programs.firefox.enable [pkgs.speechd];
  programs.firefox = {
    enable = nixosConfig != {};
    package = pkgs.firefox.override {
      nativeMessagingHosts = (
        [pkgs.plasma-browser-integration]
        ++ (lib.optional (builtins.elem nixosConfig.nur.repos.rycee.firefox-addons.tridactyl config.programs.firefox.profiles.default.extensions) pkgs.tridactyl-native)
        ++ (lib.optional (nixosConfig.services.xserver.desktopManager.gnome.enable) pkgs.gnome-browser-connector)
      );
      extraPolicies = import ./policies.nix {inherit config;};
    };
    profiles.default = {
      isDefault = true;
    };
  };
}
