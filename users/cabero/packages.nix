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
    keyboard_layout_selector
    du-dust
    dysk
    fd
    jc
    typst
    just
    transmission
    kalker
    fend
    ouch
    poppler_utils
    python312
    ripgrep
    sd
    sox
    watchexec
    xclip
  ];

  gui = with pkgs; [
    anki
    appimage-run
    arandr
    discord
    spotify
    dropbox
    evince
    feh
    gparted
    meld
    qalculate-gtk
    vlc
    zoom-us
    google-chrome
    zotero
  ];
in {
  home.packages = cli ++ gui;
}
