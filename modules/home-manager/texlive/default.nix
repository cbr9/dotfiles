{
  config,
  pkgs,
  ...
}: {
  programs.texlive = {
    enable = config.home.username == "decabera";
    packageSet = pkgs.stable.texlive;
    extraPackages = tpkgs: {inherit (tpkgs) scheme-full;};
  };
}
