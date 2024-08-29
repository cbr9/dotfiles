{
  pkgs,
  config,
  ...
}: {
  users.users.cabero = {
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel" "fuse" "docker" "networkmanager"];
    shell = pkgs.fish;
  };

  age.secrets = {
    cabero-15582531.file = ../../secrets/cabero-15582531.age; # keychain
    cabero-15582547.file = ../../secrets/cabero-15582547.age; # loose
  };

  security.pam.yubico = {
    enable = true;
    debug = false;
    mode = "challenge-response";
    id = [
      "15582547"
      "15582531"
    ];
    challengeResponsePath = "/run/agenix";
  };

  services.pcscd.enable = true;

  home-manager.users.root = {
    programs.helix = config.home-manager.users.cabero.programs.helix;
    home.stateVersion = config.home-manager.users.cabero.home.stateVersion;
    stylix.targets = config.home-manager.users.cabero.stylix.targets;
    programs.home-manager.enable = true;
  };

  home-manager.users.cabero = rec {
    imports = [../../modules/home-manager ./packages.nix];
    home = {
      homeDirectory = "/home/${home.username}";
      stateVersion = "24.05";
    };
    programs.home-manager.enable = true;
    home.username = "cabero";
  };
}
