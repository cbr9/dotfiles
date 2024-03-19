{...}: {
  imports = [
    ./keymap.nix
    ./settings.nix
  ];

  programs.fish = {
    functions.fish_user_key_bindings = ''
      bind \cw 'set old_tty (stty -g); stty sane; ya; stty $old_tty; commandline -f repaint'
    '';
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
