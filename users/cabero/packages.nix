{pkgs, ...}: let
  cli = with pkgs; [
    agenix
    du-dust
    dysk
    fd
    fend
    jc
    just
    ouch
    poppler_utils
    ripgrep
    sd
    sox
    typst
    watchexec
    xclip
  ];

  gui = with pkgs; [
    appimage-run
    arandr
    evince
    feh
    google-chrome
    gparted
    meld
    qalculate-gtk
    spotify
    vlc
    webtorrent_desktop
    zoom-us
    insync
    obsidian
  ];
in {
  home.packages = cli ++ gui;
}
