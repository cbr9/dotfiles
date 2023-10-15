{pkgs, ...}: {
  programs.texlive = {
    enable = true;
    packageSet = pkgs.stable.texlive;
    extraPackages = tpkgs: {inherit (tpkgs) scheme-full;};
  };
}
