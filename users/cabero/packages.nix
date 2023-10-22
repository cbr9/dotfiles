{pkgs, ...}: let
  cli = with pkgs; [
    aichat
    du-dust
    duden
    dysk
    fd
    go
    just
    nodePackages.webtorrent-cli
    ouch
    poppler_utils
    python312
    ripgrep
    sd
    sox
    todoist
    typst
    watchexec
    xclip
  ];

  gui = with pkgs; [
    anki
    appimage-run
    arandr
    discord
    etcher
    evince
    feh
    filen-desktop
    gnome.file-roller
    google-chrome
    gparted
    mailspring
    meld
    mpv
    obsidian
    qalculate-gtk
    todoist-electron
    vlc
    ytfzf
    ventoy-full
    zotero
  ];
in {
  home.packages = cli ++ gui;
}
