{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  config = mkIf (elem "cabero" config.sys.users) {
    users.users.cabero = {
      uid = 1000;
      createHome = true;
      isNormalUser = true;
      extraGroups = ["wheel" "fuse" "docker" "networkmanager"];
      passwordFile = config.age.secrets.cabero.path;
      shell = pkgs.fish;
    };

    age.secrets = {
      cabero-15582531.file = ../../secrets/cabero-15582531.age; # keychain
      cabero-15582547.file = ../../secrets/cabero-15582547.age; # loose
      cabero.file = ../../secrets/cabero.age;
    };

    security.pam.yubico = {
      enable = true;
      debug = false;
      mode = "challenge-response";
      id = ["15582547" "15582531"];
      challengeResponsePath = "/run/agenix";
    };

    services.pcscd.enable = true;

    programs.i3lock = {
      enable = true;
      package = pkgs.i3lock-color;
      u2fSupport = true;
    };

    home-manager.users.cabero = mkMerge (mkHome {
      configuration = {
        home.shellAliases = {
          commute = "sudo /nix/var/nix/profiles/system/specialisation/sony/bin/switch-to-configuration switch && sudo nmcli connection up sony-vpn --ask";
          chill = "sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch";
          emoji = "~/.cargo/bin/emocli -li | ${pkgs.fzf}/bin/fzf | cut -d' ' -f1 | tr -d '\n' | ${pkgs.xclip}/bin/xclip -selection clipboard";
        };
        home.sessionPath = [
          "${config.home-manager.users.cabero.home.homeDirectory}/.cargo/bin"
        ];
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
