{...}: {
  programs.firefox.profiles.default.bookmarks = [
    {
      name = "Udemy";
      url = "https://www.udemy.com/";
      keyword = "udemy";
      tags = ["learning" "education"];
    }

    {
      name = "Home Manager Options";
      url = "https://rycee.gitlab.io/home-manager/options.html";
      keyword = "hm";
      tags = ["config" "nix"];
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
  ];
}
