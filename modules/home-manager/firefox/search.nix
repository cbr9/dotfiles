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
        definedAliases = ["@nixpkgs"];
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
        definedAliases = ["@nixopts"];
      };

      "Cambridge German-English Dictionary" = {
        urls = [{template = "https://dictionary.cambridge.org/dictionary/german-english/{searchTerms}";}];
        definedAliases = ["@ger"];
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

      "HuggingFace Datasets" = {
        urls = [
          {
            template = "https://huggingface.co/datasets";
            params = [
              {
                name = "search";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        definedAliases = ["@hugd"];
      };

      "HuggingFace Models" = {
        urls = [
          {
            template = "https://huggingface.co/models";
            params = [
              {
                name = "search";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        definedAliases = ["@hugm"];
      };

      "DuckDuckGo".metaData.alias = "@d";
      "Bing".metaData.hidden = true;
      "Wikipedia (en)".metaData.alias = "@wiki";
      "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    };
  };
}
