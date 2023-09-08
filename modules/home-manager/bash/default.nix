{config, ...}: let
  nix = "${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh";
in {
  programs.bash = {
    enable = true;
    profileExtra = ''
      if [[ -f ${nix} ]]; then
        source ${nix}
        fish
      fi
    '';
  };
}
