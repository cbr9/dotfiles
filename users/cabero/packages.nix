{pkgs, ...}: let
  cli = with pkgs; [
    aichat
    carapace
    duden
    go
    todoist
    just
    watchexec
    dysk
    poppler_utils
    nodePackages.webtorrent-cli
    ripgrep
    xclip
    fd
    sox
    ouch
    du-dust
    sd
  ];

  gui = with pkgs; [
    evince
    speedcrunch
    mpv
    mailspring
    insync
    obsidian
    google-chrome
    anki
    feh
    zotero
    todoist-electron
    vlc
    ytfzf
    gnome.file-roller
  ];
in {
  home.packages = cli ++ gui;
}
