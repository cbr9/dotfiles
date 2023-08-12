{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = {
        enableGnomeExtensions = config.services.xserver.desktopManager.gnome.enable;
      };
    };
    #   profiles.default = {
    #     isDefault = true;
    #     bookmarks = [
    #       {
    #         name = "Toolbar";
    #         toolbar = true;
    #         bookmarks = [
    #           {
    #             name = "Udemy";
    #             url = "https://www.udemy.com/";
    #           }
    #         ];
    #       }
    #     ];

    #     search = {
    #       default = "DuckDuckGo";
    #       force = false;
    #       engines = {
    #         "Nix Packages" = {
    #           urls = [
    #             {
    #               template = "https://search.nixos.org/packages";
    #               params = [
    #                 {
    #                   name = "type";
    #                   value = "packages";
    #                 }
    #                 {
    #                   name = "query";
    #                   value = "{searchTerms}";
    #                 }
    #               ];
    #             }
    #           ];

    #           icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    #           definedAliases = ["@np"];
    #         };

    #         "NixOS Wiki" = {
    #           urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
    #           iconUpdateURL = "https://nixos.wiki/favicon.png";
    #           updateInterval = 24 * 60 * 60 * 1000; # every day
    #           definedAliases = ["@nw"];
    #         };

    #         "DuckDuckGo".metaData.alias = "@d";
    #         "Bing".metaData.hidden = true;
    #         "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    #       };
    #     };
    #   };
  };
}
