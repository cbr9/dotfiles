{
  pkgs,
  lib,
  nixosConfig,
  ...
}:
with lib; {
  stylix.targets.vscode.enable = false;
  programs.vscode = {
    enable = false;
    mutableExtensionsDir = nixosConfig == {};
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      brettm12345.nixfmt-vscode
      james-yu.latex-workshop
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-vscode-remote.remote-ssh
      rust-lang.rust-analyzer
      thenuprojectcontributors.vscode-nushell-lang
      tomoki1207.pdf
      vscodevim.vim
    ];

    userSettings = {
      "remote.SSH.showLoginTerminal" = true;
      "remote.SSH.remotePlatform" = {
        "phoenix.ims.uni-stuttgart.de" = "linux";
        "strauss.ims.uni-stuttgart.de" = "linux";
        "kiwi.ims.uni-stuttgart.de" = "linux";
        "destc0strapp15" = "linux";
      };
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "python.analysis.autoImportCompletions" = true;
      "window.zoomLevel" = 1;
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
      "workbench.colorCustomizations" = {};
    };
  };
}
