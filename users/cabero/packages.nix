{pkgs, ...}: let
  cli = with pkgs; [
    aichat
    carapace
    typst
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
    discord
    zathura
  ];
in {
  home.packages = cli ++ gui;
}
