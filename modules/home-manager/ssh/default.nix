{
  nixosConfig,
  config,
  lib,
  ...
}: let
  _1passwordAgent = {
    enable = nixosConfig != {} && nixosConfig.programs._1password-gui.enable && nixosConfig.programs._1password-gui.sshAgent;
    path = "${config.home.homeDirectory}/.1password/agent.sock";
  };
in {
  home.sessionVariables = lib.mkIf _1passwordAgent.enable {
    SSH_AUTH_SOCK = _1passwordAgent.path;
  };
  programs.ssh = {
    enable = true;
    forwardAgent = _1passwordAgent.enable;
    extraConfig = lib.mkIf _1passwordAgent.enable ''
      IdentityAgent ${_1passwordAgent.path}
    '';
    matchBlocks = {
      destc0strapp15 = {
        hostname = "destc0strapp15";
        user = "decabera";
      };
    };
  };
}
