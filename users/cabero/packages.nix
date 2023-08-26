{pkgs, ...}: let
  cli = with pkgs; [
    just
    gptcommit
    watchexec
    sph2pipe
    poppler_utils
    typst-master
    nodePackages.webtorrent-cli
    termusic
    rclone
    ripgrep
    # ripgrep-all
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
    kitty
    obsidian
    google-chrome
    anki
    feh
    zotero
    todoist-electron
    vlc
  ];
in {
  home.packages = cli ++ gui;
}
