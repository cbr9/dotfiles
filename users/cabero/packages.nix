{pkgs, ...}: let
  cli = with pkgs; [
    du-dust
    dysk
    fd
    go
    just
    nodePackages.webtorrent-cli
    ouch
    poppler_utils
    python312
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
    discord
    dropbox
    evince
    feh
    filen-desktop
    gnome.file-roller
    google-chrome
    gparted
    mailspring
    meld
    mpv
    obsidian
    qalculate-gtk
    slack
    todoist-electron
    vlc
    zotero
  ];
in {
  home.packages = cli ++ gui;
}
