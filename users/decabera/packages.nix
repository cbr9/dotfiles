{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI
    just
    home-manager
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
