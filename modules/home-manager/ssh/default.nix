{
  nixosConfig,
  config,
  lib,
  ...
}: let
  enable1PasswordAgent = nixosConfig != {} && nixosConfig.programs._1password-gui.enable && nixosConfig.programs._1password-gui.sshAgent;
  _1passwordAgent = "${config.home.homeDirectory}/.1password/agent.sock";
in {
  home.sessionVariables = lib.mkIf enable1PasswordAgent {
    SSH_AUTH_SOCK = _1passwordAgent;
  };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    matchBlocks."*" = lib.mkIf enable1PasswordAgent {
      extraOptions = {
        IdentityAgent = _1passwordAgent;
      };
    };
  };
}
