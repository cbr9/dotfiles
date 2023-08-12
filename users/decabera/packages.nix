{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI
    just
    home-manager
    typst
    ripgrep
    ripgrep-all
    xclip
    erdtree
    fd
    watchexec
    sox
    ouch
    tldr
    tokei
    hyperfine
    du-dust
    sd
    lfs
  ];
}
