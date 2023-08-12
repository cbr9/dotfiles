{
  pkgs,
  lib,
  nixosConfig,
  ...
}: {
  imports = [
    ./alacritty
    ./atuin
    ./bat
    ./bash
    ./borgmatic
    ./broot
    ./boxxy
    ./bottom
    ./direnv
    ./exa
    ./espanso
    ./fzf
    ./fish
    ./firefox
    ./gh
    ./git
    ./gitui
    ./helix
    ./lf
    ./lazygit
    ./man
    ./nextcloud-client
    ./neovim
    ./nix
    ./nushell
    ./organize
    ./redshift
    ./ssh
    ./screen-locker
    ./skim
    ./starship
    ./texlive
    ./topgrade
    ./vscode
    ./xdg
    ./zellij
    ./zoxide
    ./zsh
  ];

  home.activation = lib.mkIf (nixosConfig != {}) {
    background = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.feh}/bin/feh --bg-fill ${nixosConfig.stylix.image} &
      ${pkgs.betterlockscreen}/bin/betterlockscreen -u ${nixosConfig.stylix.image} &
    '';
  };
}
