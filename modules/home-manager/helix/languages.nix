{
  nixosConfig,
  lib,
  pkgs,
  ...
}:
with pkgs;
{
  # keep this for the future
  programs.helix.languages = rec {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        config = { }; # <- this is the important line
      };
      nil = {
        command = "nil";
        config = {
          nix.flake = {
            autoArchive = true;
            autoEvalInputs = true;
          };
        };
      };
      rust-analyzer.config = {
        checkOnSave.command = "clippy";
        cachePriming.enable = false;
        diagnostics.experimental.enable = true;
        check.features = "all";
      };
      lua-language-server =
        let
          ifAwesome =
            list:
            lib.optionals (
              nixosConfig != { } && nixosConfig.services.xserver.windowManager.awesome.enable
            ) list;
        in
        {
          command = "lua-language-server";
          config.Lua = {
            format = {
              enable = true;
              defaultConfig = {
                indent_style = "tab";
                indent_size = "4";
              };
            };

            hint = {
              enable = true;
              arrayIndex = "Enable";
              setType = true;
              paramName = "All";
              paramType = true;
              await = true;
            };

            diagnostics.globals = ifAwesome [
              "awesome"
              "button"
              "dbus"
              "drawable"
              "drawin"
              "key"
              "keygrabber"
              "mousegrabber"
              "selection"
              "tag"
              "window"
              "screen"
              "mouse"
              "root"
              "client"
            ];

            workspace.library = ifAwesome [ "${pkgs.awesome}/share/awesome/lib" ];
          };
        };
    };

    formatter = {
      black = {
        command = "black";
        args = [
          "-"
          "-q"
        ];
      };
      nixfmt = {
        command = "nixfmt";
      };
    };

    language = [
      {
        name = "nix";
        scope = "source.nix";
        auto-format = true;
        formatter = formatter.nixfmt;
      }
    ];
  };
}
