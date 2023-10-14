{pkgs, ...}: {
  programs.texlive = {
    enable = false;
    packageSet = pkgs.stable.texlive;
    extraPackages = tpkgs: {inherit (tpkgs) scheme-full;};
  };
}
