{
  pkgs,
  lib,
  ...
}:
with lib; {
  options.programs._1password-gui = {
    sshAgent = mkEnableOption "1Password SSH Agent" // {default = true;};
  };
  config = {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        package = pkgs._1password-gui-beta;
        enable = true;
        polkitPolicyOwners = ["cabero"];
      };
    };
  };
}
