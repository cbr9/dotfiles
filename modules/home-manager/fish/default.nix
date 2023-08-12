{
  pkgs,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    functions = {
      fish_user_key_bindings = ''
        bind \ce edit_command_buffer
      '';
    };
    shellInit = let
      HOME = "${config.home.homeDirectory}";
    in ''
      fish_config theme choose "ayu Dark"
      set -gx fish_escape_delay_ms 1000

      if test -f ${HOME}/.nix-profile/etc/profile.d/nix.fish
        source ${HOME}/.nix-profile/etc/profile.d/nix.fish
      end

      if test -f ${HOME}/.config/op/plugins
        source ${HOME}/.config/op/plugins.sh
      end
    '';
    plugins = with pkgs; [
      {
        # sudo plugin (Esc+Esc)
        name = "sudope";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-sudope";
          rev = "83919a692bc1194aa322f3627c859fecace5f496";
          sha256 = "sha256-pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
        };
      }
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
      {
        # paired symbols
        name = "pisces";
        src = fishPlugins.pisces.src;
      }
    ];
  };
}
