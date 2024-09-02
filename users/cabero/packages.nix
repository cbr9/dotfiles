{pkgs, ...}: let
  keyboard_layout_selector =
    pkgs.writeScriptBin "switch_keyboard_layout"
    ''
      #!/usr/bin/env nu
      let current_layout = ${pkgs.xorg.setxkbmap}/bin/setxkbmap -query | detect columns --no-headers | update column0 {|it| $it.column0 | str replace ":" ""} | transpose | reject column0 | headers | str trim | get layout.0

      let layouts = {
          us: "🇺🇸",
          de: "🇩🇪",
          es: "🇪🇸",
          gr: "🇬🇷",
      }

      let keys = $layouts | columns | to text
      let flag = $layouts | get $current_layout
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap us
      let selection = ($keys | rofi -dmenu -p "Keyboard Layout" -mesg $'Current layout: ($flag)')
      if ($selection | is-empty) {
        ${pkgs.xorg.setxkbmap}/bin/setxkbmap $current_layout
        return
      }
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap $selection
    '';
  cli = with pkgs; [
    agenix
    du-dust
    dysk
    fd
    fend
    jc
    just
    kalker
    keyboard_layout_selector
    ouch
    poppler_utils
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
    google-chrome
    gparted
    meld
    qalculate-gtk
    spotify
    vlc
    webtorrent_desktop
    todoist-electron
    zoom-us
    zotero
  ];
in {
  home.packages = cli ++ gui;
}
