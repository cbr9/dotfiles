{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  config = mkIf (elem "cabero" config.sys.users) {
    age.secrets.cabero.file = ../../secrets/cabero.age;
    users.users.cabero = {
      uid = 1000;
      createHome = true;
      isNormalUser = true;
      extraGroups = ["wheel" "fuse" "docker" "networkmanager"];
      passwordFile = config.age.secrets.cabero.path;
      shell = pkgs.fish;
    };

    home-manager.users.cabero = mkMerge (mkHome {
      configuration = {
        home.shellAliases = {
          commute = ''
            sudo /nix/var/nix/profiles/system/specialisation/sony/bin/switch-to-configuration switch
            i3-msg restart >> /dev/null
            sudo nmcli connection up sony-vpn --ask
          '';
          chill = ''
            sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
            i3-msg restart >> /dev/null
          '';
        };
        stylix = {
          targets.alacritty.enable = false;
          targets.zellij.enable = false;
        };
        imports = [
          ./packages.nix
          ./email.nix
        ];
        home.sessionVariables = rec {
          CACHIX_AUTH_TOKEN = "op://Personal/Cachix/authtoken";
          OPENAI_API_KEY = "op://Personal/OpenAI/api-key";
          GPTCOMMIT__OPENAI__API_KEY = OPENAI_API_KEY;
          GPTCOMMIT__OPENAI__MODEL = "gpt-3.5-turbo";
        };

        home.username = "cabero";
      };
    });
  };
}
