{pkgs, ...}: let
  cli = with pkgs; [
    agenix
    du-dust
    dysk
    fd
    jc
    just
    kalker
    ouch
    poppler_utils
    python312
    ripgrep
    sd
    sox
    watchexec
    xclip
    yazi
  ];

  gui = with pkgs; [
    anki
    appimage-run
    arandr
    discord
    spotify
    dropbox
    evince
    feh
    gnome.file-roller
    gnome.nautilus
    google-chrome
    gparted
    meld
    qalculate-gtk
    vlc
    zoom-us
    zotero
  ];
in {
  home.packages = cli ++ gui;
}
