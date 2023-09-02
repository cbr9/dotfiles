{
  pkgs,
  config,
  ...
}: let
  emojiPicker = pkgs.writeScriptBin "emoji" ''
    ${config.home.homeDirectory}/.cargo/bin/emocli -li | ${pkgs.fzf}/bin/fzf | cut -d' ' -f1 | tr -d '\n' | ${pkgs.xclip}/bin/xclip -selection clipboard
  '';
in {
  home.packages = [emojiPicker];
  programs.fish = {
    enable = true;

    functions = {
      fish_user_key_bindings = ''
        bind L accept-autosuggestion  # shift+l
      '';
    };

    shellInit = let
      HOME = "${config.home.homeDirectory}";
    in ''
      set -g fish_greeting ""
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
