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
  programs.ssh = {
    enable = true;
    forwardAgent = _1passwordAgent.enable;
    extraConfig = lib.optionalString _1passwordAgent.enable "IdentityAgent ${_1passwordAgent.path}";
  };
}
