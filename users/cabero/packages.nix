{pkgs, ...}: let
  cli = with pkgs; [
    agenix
    du-dust
    dysk
    fd
    go
    jc
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
    appimage-run
    arandr
    discord
    dropbox
    evince
    feh
    gnome.file-roller
    google-chrome
    gparted
    insync
    mailspring
    meld
    mpv
    gnome.nautilus
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
