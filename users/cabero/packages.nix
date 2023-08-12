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
    anytype
    evince
    speedcrunch
    obsidian
    lame
    mpv
    mplayer
    nextcloud-client
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
