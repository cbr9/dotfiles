{
  pkgs,
  lib,
  config,
  nixosConfig ? { },
  ...
}:
with lib;
{
  home.packages = [ pkgs.git-crypt ];
  programs.fish.shellAbbrs = mkIf config.programs.git.enable {
    gr = "git restore";
    gd = "git diff";
    gs = "git status";
    gc = "git commit";
    ga = "git add";
    gp = "git push";
    gl = "git pull";
  };
  programs.git = {
    userName = "cbr9";
    userEmail = "cabero96@protonmail.com";
    enable = true;
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        dark = true;
      };
    };
    lfs.enable = true;
    aliases = {
      st = "status";
      p = "push";
      c = "commit";
      a = "add";
    };

    ignores = [
      "*~"
      "*.swp"
    ];
    extraConfig = {
      merge.conflictstyle = "diff3";
      core.editor = "hx";
      init.defaultBranch = "main";
      gpg.format = "ssh";
      gpg."ssh".program = lib.mkIf (
        nixosConfig != { }
        && nixosConfig.programs._1password-gui.enable
        && nixosConfig.programs._1password-gui.sshAgent
      ) "${nixosConfig.programs._1password-gui.package}/bin/op-ssh-sign";
      commit.gpgsign = true;
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe0bugU6xBMHw8bIMlvEr9TnZ3S185UkTzRJUcmcW6v";
      push.autoSetupRemote = true;
      merge.tool = "meld";
    };
  };
}
