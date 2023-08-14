{...}: {
  programs.firefox.profiles.default.bookmarks = [
    {
      name = "Udemy";
      url = "https://www.udemy.com/";
      keyword = "udemy";
      tags = ["learning" "education"];
    }
    {
      name = "Dotfiles";
      url = "https://www.github.com/cbr9/dotfiles";
      keyword = "dotfiles";
      tags = ["config" "code" "nix"];
    }
    {
      name = "Home Manager Options";
      url = "https://rycee.gitlab.io/home-manager/options.html";
      keyword = "hm";
      tags = ["config" "nix"];
    }
  ];
}
