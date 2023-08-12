{config, ...}: {
  programs.texlive = {
    enable = config.home.username != "decabera";
    extraPackages = tpkgs: {inherit (tpkgs) scheme-full;};
  };
}
