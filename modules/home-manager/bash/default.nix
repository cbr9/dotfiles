{config, ...}: let
  nixSh = "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh";
in {
  programs.bash = {
    enable = false;
    profileExtra = ''
      if [[ -f ${nixSh} ]]; then
        source ${nixSh}
      fi
    '';
  };
}
