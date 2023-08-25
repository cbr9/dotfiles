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
        name = "Udemy";
        url = "https://www.udemy.com/";
        keyword = "udemy";
        tags = ["learning" "education"];
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
            name = "Dotfiles";
            url = "https://www.github.com/cbr9/dotfiles";
            keyword = "dotfiles";
            tags = ["config" "code" "nix"];
          }
          {
            name = "Helix";
            url = "https://github.com/helix-editor/helix";
            keyword = "helix";
            tags = ["editor" "terminal" "cli"];
          }
          {
            name = "Typst";
            url = "https://github.com/typst/typst";
            keyword = "typst";
            tags = ["typeset" "latex"];
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
            tags = ["cli" "terminal"];
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
