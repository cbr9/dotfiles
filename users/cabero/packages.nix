{pkgs, ...}: let
  cli = with pkgs; [
    du-dust
    dysk
    fd
    go
    just
    nodePackages.webtorrent-cli
    ookla-speedtest
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
    anki
    insync
    appimage-run
    arandr
    discord
    dropbox
    evince
    feh
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
