{pkgs, ...}: let
  cli = with pkgs; [
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
