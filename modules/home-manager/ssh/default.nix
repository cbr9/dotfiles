{
  nixosConfig,
  config,
  lib,
  ...
}: let
  enable1PasswordAgent = nixosConfig != {} && nixosConfig.programs._1password-gui.enable && nixosConfig.programs._1password-gui.sshAgent;
  _1passwordAgent = "${config.home.homeDirectory}/.1password/agent.sock";
in {
  # home.sessionVariables = lib.mkIf enable1PasswordAgent {
  #   SSH_AUTH_SOCK = _1passwordAgent;
  # };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = lib.mkIf enable1PasswordAgent ''
      IdentityAgent ${_1passwordAgent}
    '';

    matchBlocks = {
      destc0strapp15 = {
        hostname = "destc0strapp15";
        user = "decabera";
        forwardX11 = true;
        forwardX11Trusted = true;
        forwardAgent = true;
      };
    };
  };
}
