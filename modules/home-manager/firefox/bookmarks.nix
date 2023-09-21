{
  nixosConfig,
  lib,
  ...
}: {
  programs.firefox.profiles.default.bookmarks = lib.mkIf (nixosConfig != {}) (
    lib.optionals (nixosConfig.sony.enable) [
      {
        name = "Workday";
        url = "https://www.myworkday.com/sonyglobal/d/home.htmld";
        keyword = "workday";
      }
      {
        name = "Sony GitLab";
        url = "https://gitlab.stc.eu.sony.com/users/sign_in";
        keyword = "gitlab";
      }
      {
        name = "Outlook";
        url = "https://outlook.office365.com";
        keyword = "email";
      }
    ]
    ++ [
      {
        name = "Coursera";
        url = "https://www.coursera.org/";
        keyword = "coursera";
        tags = ["learning" "education"];
      }
      {
        name = "Udemy";
        url = "https://www.udemy.com/";
        keyword = "udemy";
        tags = ["learning" "education"];
      }
      {
        name = "Regex101";
        url = "https://regex101.com";
        keyword = "regex";
        tags = ["testing" "code"];
      }
      {
        name = "ChatGPT";
        url = "https://chat.openai.com/";
        keyword = "chat";
        tags = ["productivity" "ai"];
      }
      {
        name = "Cambridge German-English Dictionary";
        url = "https://dictionary.cambridge.org/dictionary/german-english/";
        keyword = "german";
        tags = ["learning" "education"];
      }
      {
        name = "Google";
        toolbar = false;
        bookmarks = [
          {
            name = "Calendar";
            url = "https://calendar.google.com/";
            keyword = "cal";
            tags = ["productivity"];
          }
          {
            name = "Maps";
            url = "https://maps.google.com/";
            keyword = "maps";
            tags = [];
          }
          {
            name = "Gmail";
            url = "https://mail.google.com";
            keyword = "gmail";
            tags = ["email" "productivity"];
          }
        ];
      }
      {
        name = "NixOS";
        toolbar = false;
        bookmarks = [
          {
            name = "Home Manager Options";
            url = "https://rycee.gitlab.io/home-manager/options.html";
            keyword = "hm";
            tags = ["nixos" "hm"];
          }
          {
            name = "NixOS Options";
            url = "https://search.nixos.org/options";
            keyword = "nop";
            tags = ["nixos" "options"];
          }
        ];
      }
      {
        name = "GitHub Projects";
        toolbar = false;
        bookmarks = [
          {
            # not a project, but will do
            name = "GitHub";
            url = "https://www.github.com";
            keyword = "gh";
            tags = ["code"];
          }
          {
            name = "Dotfiles";
            url = "https://www.github.com/cbr9/dotfiles";
            keyword = "dotfiles";
            tags = ["config" "code" "nix"];
          }
          {
            name = "Kitty";
            url = "https://github.com/kovidgoyal/kitty";
            keyword = "kitty";
            tags = ["terminal" "code"];
          }
          {
            name = "Nushell";
            url = "https://github.com/nushell/nushell";
            keyword = "nushell";
            tags = ["shell" "code" "rust" "cli"];
          }
          {
            name = "Helix";
            url = "https://github.com/helix-editor/helix";
            keyword = "helix";
            tags = ["editor" "cli" "rust"];
          }
          {
            name = "Typst";
            url = "https://github.com/typst/typst";
            keyword = "typst";
            tags = ["typeset" "latex" "rust"];
          }
          {
            name = "Nixpkgs";
            url = "https://github.com/NixOS/nixpkgs";
            keyword = "nixpkgs";
            tags = ["nix" "nixos" "pkgs"];
          }
          {
            name = "Zellij";
            url = "https://github.com/zellij-org/zellij";
            keyword = "zellij";
            tags = ["cli" "terminal" "rust" "multiplexer"];
          }
        ];
      }
      {
        name = "LinkedIn";
        keyword = "linkedin";
        url = "https://www.linkedin.com/";
      }
      {
        name = "Proton";
        url = "https://mail.proton.me";
        keyword = "proton";
        tags = ["email"];
      }
    ]
  );
}
