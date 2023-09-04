{...}: {
  programs.texlive = {
    enable = false;
    extraPackages = tpkgs: {inherit (tpkgs) scheme-full;};
  };
}
