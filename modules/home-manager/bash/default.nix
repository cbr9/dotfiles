{config, ...}: let
  nixSh = "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh";
in {
  programs.bash = {
    enable = true;
    profileExtra = ''
      if [[ -f ${nixSh} ]]; then
        source ${nixSh}
      fi
    '';
  };
}
