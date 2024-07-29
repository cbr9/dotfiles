{pkgs, ...}: {
  programs.firefox.profiles.default.search = {
    default = "DuckDuckGo";
    force = true;
    engines = {
      "NixOS packages" = {
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
        definedAliases = ["@pkg"];
      };
      "NixOS options" = {
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
        definedAliases = ["@opt"];
      };
      "Home Manager Options" = {
        urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
        definedAliases = ["@hm"];
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
        definedAliases = ["@you"];
      };

      Amazon = {
        urls = [{template = "https://amazon.de/s?k={searchTerms}";}];
        definedAliases = ["@am"];
      };

      "DuckDuckGo".metaData.alias = "@d";
      "Bing".metaData.hidden = true;
      "Wikipedia (en)".metaData.alias = "@wiki";
      "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    };
  };
}
