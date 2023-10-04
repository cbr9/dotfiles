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
    qalculate-gtk
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
    zathura
  ];
in {
  home.packages = cli ++ gui;
}
