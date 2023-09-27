{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    enable = true;

    functions = {
      fish_user_key_bindings = ''
        # To find out what sequence a key combination sends, you can use fish_key_reader
        bind \el accept-autosuggestion  # alt+l
        bind \eh 'dm-hub -f'
        bind \ek up-or-search # alt+k
        bind \ej down-or-search # alt+j
        bind \ce 'fish_commandline_prepend $EDITOR'
      '';
    };

    shellInit = let
      HOME = "${config.home.homeDirectory}";
    in ''
      set -g fish_greeting ""

      if test -f ${HOME}/.nix-profile/etc/profile.d/nix.fish
        source ${HOME}/.nix-profile/etc/profile.d/nix.fish
      end

      if test -f ${HOME}/.config/op/plugins
        source ${HOME}/.config/op/plugins.sh
      end
    '';

    plugins = with pkgs; [
      {
        #  automatically receive notifications when long processes finish.
        name = "done";
        src = fishPlugins.done.src;
      }
      {
        # text expansions
        name = "puffer";
        src = fishPlugins.puffer.src;
      }
    ];
  };
}
