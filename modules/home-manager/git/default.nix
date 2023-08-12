{
  pkgs,
  nixosConfig ? {},
  ...
}: let
  sony = nixosConfig != {} && nixosConfig.sony.enable;
  userName = (
    if sony
    then "andres.caberobusto"
    else "cbr9"
  );
  userEmail = (
    if sony
    then "andres.caberobusto@sony.com"
    else "cabero96@protonmail.com"
  );
in {
  home.shellAliases = {
    gp = "git push";
    gc = "git commit";
    ga = "git add";
  };
  home.packages = [pkgs.git-crypt];
  programs.git = {
    inherit userName userEmail;
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
    ignores = ["*~" "*.swp"];
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe0bugU6xBMHw8bIMlvEr9TnZ3S185UkTzRJUcmcW6v";
      signByDefault = true;
      gpgPath = (
        if (nixosConfig != {} && nixosConfig.programs._1password-gui.enable && nixosConfig.programs._1password-gui.sshAgent)
        then "${pkgs._1password-gui}/bin/op-ssh-sign"
        else "${pkgs.gnupg}/bin/gpg2"
      );
    };
    extraConfig = {
      merge = {conflictstyle = "diff3";};
      core = {editor = "hx";};
      init = {defaultBranch = "main";};
      gpg.format = "ssh";
    };
  };
}
