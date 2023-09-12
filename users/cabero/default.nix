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
      shell = pkgs.nushellFull;
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

    home-manager.users.root = {
      stylix.targets = config.home-manager.users.cabero.stylix.targets;
      home.stateVersion = config.home-manager.users.cabero.home.stateVersion;
      programs.helix = config.home-manager.users.cabero.programs.helix;
    };

    home-manager.users.cabero = mkMerge (mkHome {
      configuration = {
        home.sessionPath = [
          "${config.home-manager.users.cabero.home.homeDirectory}/.cargo/bin"
        ];
        imports = [./packages.nix];

        home.sessionVariables = {
          OPENAI_API_KEY = "op://Personal/OpenAI/api-key";
        };

        home.username = "cabero";
      };
    });
  };
}
