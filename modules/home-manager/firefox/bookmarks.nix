{
  nixosConfig,
  lib,
  ...
}: {
  programs.firefox.profiles.default.bookmarks = lib.mkIf (nixosConfig != {}) [
    {
      name = "Coursera";
      url = "https://www.coursera.org/";
      keyword = "coursera";
    }
    {
      name = "Privacy Tools";
      url = "https://www.privacytools.io";
      keyword = "privacy";
    }
    {
      name = "Fastmail";
      url = "app.fastmail.com";
      keyword = "mail";
    }
    {
      name = "Leetcode";
      url = "https://leetcode.com/";
      keyword = "leetcode";
    }
    {
      name = "Hackerrank";
      url = "https://hackerrank.com/";
      keyword = "hackerrank";
    }
    {
      name = "Moonlander";
      url = "https://www.zsa.io/moonlander/";
      keyword = "moonlander";
    }
    {
      name = "BrainFM";
      url = "https://my.brain.fm/focus";
      keyword = "focus";
    }
    {
      name = "Ilias";
      url = "https://ilias3.uni-stuttgart.de";
      keyword = "ilias";
    }
    {
      name = "University Email";
      url = "https://mail.uni-stuttgart.de/";
      keyword = "unimail";
    }
    {
      name = "Udemy";
      url = "https://www.udemy.com/";
      keyword = "udemy";
    }
    {
      name = "Regex101";
      url = "https://regex101.com";
      keyword = "regex";
    }
    {
      name = "Hydra";
      url = "https://hydra.cc";
      keyword = "hydra";
    }
    {
      name = "ChatGPT";
      url = "https://chat.openai.com/";
      keyword = "chat";
    }
    {
      name = "Cambridge German-English Dictionary";
      url = "https://dictionary.cambridge.org/dictionary/german-english/";
      keyword = "german";
    }
    {
      name = "Cambridge English Dictionary";
      url = "https://dictionary.cambridge.org/dictionary/english/";
      keyword = "english";
    }
    {
      name = "Google";
      toolbar = false;
      bookmarks = [
        {
          name = "Google Calendar";
          url = "https://calendar.google.com/";
          keyword = "cal";
        }
        {
          name = "Google Maps";
          url = "https://maps.google.com/";
          keyword = "maps";
        }
        {
          name = "Google Mail";
          url = "https://mail.google.com";
          keyword = "gmail";
        }
        {
          name = "YouTube";
          url = "https://www.youtube.com/";
          keyword = "yt";
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
        }
        {
          name = "NixOS Options";
          url = "https://search.nixos.org/options";
          keyword = "nop";
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
        }
        {
          # not a project, but will do
          name = "GitHub Repositories";
          url = "https://github.com/cbr9?tab=repositories";
          keyword = "repos";
        }
        {
          name = "Papis";
          url = "https://www.github.com/papis/papis";
          keyword = "papis";
        }
        {
          name = "Dotfiles";
          url = "https://www.github.com/cbr9/dotfiles";
          keyword = "dotfiles";
        }
        {
          name = "Kitty";
          url = "https://github.com/kovidgoyal/kitty";
          keyword = "kitty";
        }
        {
          name = "Second Brain";
          url = "https://github.com/cbr9/second-brain";
          keyword = "second-brain";
        }
        {
          name = "Nushell";
          url = "https://github.com/nushell/nushell";
          keyword = "nushell";
        }
        {
          name = "Zoxide";
          url = "https://github.com/ajeetdsouza/zoxide";
          keyword = "zoxide";
        }
        {
          name = "Helix";
          url = "https://github.com/helix-editor/helix";
          keyword = "helix";
        }
        {
          name = "Typst";
          url = "https://github.com/typst/typst";
          keyword = "typst";
        }
        {
          name = "Nixpkgs";
          url = "https://github.com/NixOS/nixpkgs";
          keyword = "nixpkgs";
        }
        {
          name = "Zellij";
          url = "https://github.com/zellij-org/zellij";
          keyword = "zellij";
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
    }
  ];
}
