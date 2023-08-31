{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI
    just
    dysk
    home-manager
    dysk
    typst
    ripgrep
    xclip
    fd
    watchexec
    sox
    ouch
    du-dust
    sd
  ];
}
