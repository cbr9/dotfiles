{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.zellij;
  boolToString = bool:
    if bool
    then "true"
    else "false";
in {
  config = {
    stylix.targets.zellij.enable = false;
    home.shellAliases = lib.mkIf cfg.enable {
      zj = "zellij";
    };

    xdg.configFile."zellij/config.kdl" = {
      # the toKDL implementation in HM is clunky and confusing
      enable = cfg.enable;
      text = ( # kdl
        ''
          default_layout "compact"
          default_shell "fish"
          keybinds {
          	normal {
          		unbind "Alt l" "Alt h" "Alt k" "Alt j"
          	}
          }
          pane_frames false
          theme "gruvbox-dark"
          ui {
          	pane_frames {
          		hide_session_name ${boolToString false}
          	}
          }
        ''
      );
    };

    home.sessionVariables = lib.mkIf cfg.enable {
      ZELLIJ_AUTO_ATTACH = boolToString false;
      ZELLIJ_AUTO_EXIT = boolToString false;
    };
    programs.zellij = {
      enable = true;
      package = pkgs.zellij.overrideAttrs (final: old: rec {
        name = "zellij";
        rev = "b677ffe75fb8e518441a0bd7df02abfb8dcc4989";
        hash = "sha256-I0m/LSaDnFtsOZ4UUsvr/uMhNsbzvs3+RpnrcKqNrWw=";
        depHash = "sha256-RGQe0fSnNYCDBhJ5pGbm7TPSoRa9x60NlGo3rgTJD6Y=";
        src = pkgs.fetchFromGitHub {
          inherit rev hash;
          owner = "zellij-org";
          repo = "zellij";
        };
        cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
          name = "${name}-vendor.tar.gz";
          inherit src;
          outputHash = depHash;
        });
      });

      enableZshIntegration = false;
      enableBashIntegration = false;
      enableFishIntegration = false;
    };
  };
}
