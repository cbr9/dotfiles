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
      keywork = "dotfiles";
      tags = ["config" "code" "nix"];
    }
  ];
}
