{
  nixosConfig,
  config,
  lib,
  ...
}: let
  enable1PasswordAgent = nixosConfig != {} && nixosConfig.programs._1password-gui.enable && nixosConfig.programs._1password-gui.sshAgent;
in {
  programs.ssh = {
    enable = true;
    forwardAgent = enable1PasswordAgent;
    extraConfig = lib.mkIf enable1PasswordAgent ''
      IdentityAgent "${config.home.homeDirectory}/.1password/agent.sock"
    '';
    matchBlocks = {
      destc0strapp15 = {
        hostname = "destc0strapp15";
        user = "decabera";
        forwardX11 = true;
      };
    };
  };
}
