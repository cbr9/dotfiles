{pkgs, ...}: let
  cli = with pkgs; [
    aichat
    du-dust
    duden
    dysk
    fd
    go
    just
    nodePackages.webtorrent-cli
    ouch
    poppler_utils
    ripgrep
    sd
    sox
    todoist
    typst
    watchexec
    xclip
  ];

  gui = with pkgs; [
    anki
    discord
    evince
    feh
    gnome.file-roller
    google-chrome
    appimage-run
    mailspring
    meld
    mpv
    obsidian
    qalculate-gtk
    pcloud
    todoist-electron
    vlc
    ytfzf
    filen
    zotero
  ];
in {
  home.packages = cli ++ gui;
}
