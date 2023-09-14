{pkgs, ...}:
with pkgs; {
  # keep this for the future
  home.packages = with pkgs; [
    nodePackages.pyright
    nodePackages.bash-language-server
    marksman
    nil
    taplo
    shellcheck
    lua-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-json-languageserver
    typst-lsp
    clippy
    python310Packages.ruff-lsp
    python311Packages.python-lsp-server
    alejandra
    black
    texlab
  ];
  programs.helix.languages = rec {
    language-server = {
      pyright = {
        command = "${pkgs.nodePackages.pyright}/bin/pyright-langserver";
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
      };
      ruff = {
        command = "${pkgs.ruff-lsp}/bin/ruff-lsp";
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
