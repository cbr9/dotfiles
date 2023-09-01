{pkgs, ...}: {
  programs.firefox.profiles.default.search = {
    default = "DuckDuckGo";
    force = true;
    engines = {
      "Nix Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "channel";
                value = "unstable";
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
      "Nix Options" = {
        urls = [
          {
            template = "https://search.nixos.org/options";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["@nop"];
      };

      "Cambridge German-English Dictionary" = {
        urls = [{template = "https://dictionary.cambridge.org/dictionary/german-english/{searchTerms}";}];
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@ger"];
      };

      "NixOS Wiki" = {
        urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@nw"];
      };

      "YouTube" = {
        urls = [
          {
            template = "https://www.youtube.com/results";
            params = [
              {
                name = "search_query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = ["@you"];
      };

      "DuckDuckGo".metaData.alias = "@d";
      "Bing".metaData.hidden = true;
      "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    };
  };
}
