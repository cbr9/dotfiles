{
  nixosConfig,
  lib,
  pkgs,
  ...
}:
with pkgs; {
  # keep this for the future
  home.packages = with pkgs; [
    nodePackages.pyright
    nodePackages.bash-language-server
    marksman
    nil
    taplo
    shellcheck
    gopls
    delve
    lua-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver
    typst-lsp
    clippy
    ruff-lsp
    python311Packages.python-lsp-server
    alejandra
    black
    texlab
  ];
  programs.helix.languages = rec {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = ["--stdio"];
        config = {}; # <- this is the important line
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
      typst = {command = "typst-lsp";};
      rust-analyzer.config = {
        checkOnSave.command = "clippy";
        cachePriming.enable = false;
        diagnostics.experimental.enable = true;
        check.features = "all";
      };
      ruff = {
        command = "ruff-lsp";
      };
      lua-language-server = let
        ifAwesome = list: lib.optionals (nixosConfig != {} && nixosConfig.services.xserver.windowManager.awesome.enable) list;
      in {
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

          workspace.library = ifAwesome ["${pkgs.awesome}/share/awesome/lib"];
        };
      };
    };

    formatter = {
      black = {
        command = "black";
        args = ["-" "-q"];
      };
      alejandra = {command = "alejandra";};
    };

    language = [
      {
        name = "python";
        scope = "source.python";
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = " ";
        };
        formatter = formatter.black;
        language-servers = ["pyright" "ruff"];
      }
      {
        name = "nix";
        scope = "source.nix";
        auto-format = true;
        formatter = formatter.alejandra;
        language-servers = ["nil"];
      }
      {
        name = "typst";
        scope = "source.typst";
        roots = [];
        injection-regex = "^typst$";
        file-types = ["typ"];
        comment-token = "//";
        indent = {
          tab-width = 2;
          unit = " ";
        };
        language-servers = ["typst"];
      }
    ];
  };
}
