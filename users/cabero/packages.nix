{pkgs, ...}: let
  cli = with pkgs; [
    aichat
    duden
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
