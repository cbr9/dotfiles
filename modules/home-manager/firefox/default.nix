{
  nixosConfig,
  pkgs,
  ...
}: {
  imports = [./extensions.nix];
  programs.firefox = {
    enable = nixosConfig != {};
    package = pkgs.firefox.override {
      cfg = {
        enableGnomeExtensions = nixosConfig.services.xserver.desktopManager.gnome.enable;
      };
      extraPolicies = {
        DisplayBookmarksToolbar = "newtab";
        ShowHomeButton = true;
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
          TopSites = false;
          SponsoredTopSites = false;
          SponsoredPocket = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };

    profiles.default = {
      isDefault = true;
      settings = {
        "browser.fullscreen.autohide" = false;
      };
      bookmarks = [
        {
          name = "Udemy";
          url = "https://www.udemy.com/";
          keyword = "udemy";
          tags = ["learning" "education"];
        }
      ];

      search = {
        default = "DuckDuckGo";
        # force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };

          "DuckDuckGo".metaData.alias = "@d";
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
      };
    };
  };
}
