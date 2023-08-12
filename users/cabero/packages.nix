{pkgs, ...}: let
  cli = with pkgs; [
    just
    gptcommit
    poppler_utils
    typst-master
    nodePackages.webtorrent-cli
    termusic
    rclone
    ripgrep
    ripgrep-all
    xclip
    fd
    sox
    ouch
    tldr
    du-dust
    sd
  ];

  gui = with pkgs; [
    evince
    speedcrunch
    obsidian
    lame
    mpv
    mplayer
    google-chrome
    anki-bin
    evince
    feh
    zotero
    todoist-electron
    vlc
  ];
in {
  home.packages = cli ++ gui;
}
