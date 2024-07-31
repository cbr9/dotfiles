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
      name = "Brilliant";
      url = "https://www.brilliant.org/";
      keyword = "brilliant";
    }
    {
      name = "Gapminder";
      url = "https://www.gapminder.org";
      keyword = "gap";
    }
    {
      name = "Notion";
      url = "https://www.notion.so/";
      keyword = "notion";
    }
    {
      name = "Dropbox";
      url = "https://www.dropbox.com/home";
      keyword = "dropbox";
    }
    {
      name = "Healthline";
      url = "https://www.healthline.com";
      keyword = "health";
    }
    {
      name = "Whatsapp Web";
      url = "https://web.whatsapp.com/";
      keyword = "wp";
    }
    {
      name = "Fastmail";
      url = "https://app.fastmail.com/mail/Inbox";
      keyword = "fast";
    }
    {
      name = "Microsoft 365";
      url = "https://www.office.com";
      keyword = "office";
    }
    {
      name = "Leetcode";
      url = "https://leetcode.com/";
      keyword = "leetcode";
    }
    {
      name = "Kaggle";
      url = "https://kaggle.com/";
      keyword = "kaggle";
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
      name = "Udemy";
      url = "https://www.udemy.com/";
      keyword = "udemy";
    }
    {
      name = "ChatGPT";
      url = "https://chat.openai.com/";
      keyword = "gpt";
    }
    {
      name = "Cambridge German-English Dictionary";
      url = "https://dictionary.cambridge.org/dictionary/german-english/";
      keyword = "german";
    }
    {
      name = "WordReference";
      url = "https://www.wordreference.com/";
      keyword = "word";
    }
    {
      name = "Merriam-Webster Dictionary";
      url = "https://www.merriam-webster.com/";
      keyword = "merriam";
    }
    {
      name = "Cambridge English Dictionary";
      url = "https://dictionary.cambridge.org/dictionary/english/";
      keyword = "english";
    }
    {
      name = "ML Interviews Book";
      url = "https://huyenchip.com/ml-interviews-book/";
      keyword = "mlinterview";
    }
    {
      name = "Language Learning";
      toolbar = false;
      bookmarks = [
        {
          name = "Memrise";
          url = "https://app.memrise.com/dashboard";
          keyword = "memrise";
        }
        {
          name = "Duolingo";
          url = "https://www.duolingo.com/";
          keyword = "duolingo";
        }
        {
          name = "Forvo";
          url = "https://forvo.com/";
          keyword = "forvo";
        }
      ];
    }
    {
      name = "Blogs";
      toolbar = false;
      bookmarks = [
        {
          name = "Chip Huyen";
          url = "https://huyenchip.com/";
          keyword = "chip";
        }
        {
          name = "Jay Alammar";
          url = "https://jalammar.github.io/";
          keyword = "alammar";
        }
        {
          name = "Ivaylo Durmonski";
          url = "https://durmonski.com";
          keyword = "durmonski";
        }
        {
          name = "Awni Hannun";
          url = "https://awnihannun.com/index.html";
          keyword = "awni";
        }
        {
          name = "Jonathan Boigne";
          url = "https://jonathanbgn.com";
          keyword = "bgn";
        }
      ];
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
          name = "Dotfiles";
          url = "https://www.github.com/cbr9/dotfiles";
          keyword = "dots";
        }
        {
          name = "Organizer";
          url = "https://www.github.com/cbr9/organizer";
          keyword = "org";
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
        {
          name = "Yazi";
          url = "https://github.com/sxyazi/yazi";
          keyword = "yazi";
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
