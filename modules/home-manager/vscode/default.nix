{
  pkgs,
  lib,
  nixosConfig ? {},
  ...
}:
with lib; {
  stylix.targets.vscode.enable = false;
  programs.vscode = {
    enable = nixosConfig != {};
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-vscode-remote.remote-ssh
      bbenoist.nix
      brettm12345.nixfmt-vscode
      rust-lang.rust-analyzer
      tomoki1207.pdf
    ];

    userSettings = {
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
    };
  };

  programs.ssh.matchBlocks = {
    destc0strapp15 = {
      hostname = "destc0strapp15";
      user = "decabera";
      forwardX11 = true;
    };
  };
}
