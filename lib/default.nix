lib: let
  stateVersion = "23.05";
in {
  indexOf = element: list: let
    helper = list: index:
      if list == []
      then null
      else if builtins.head list == element
      then index
      else helper (lib.lists.drop 1 list) (index + 1);
  in
    helper list 0;

  # sorts a list of attribute sets by comparing a field in each of the attrsets, with a user-defined order
  sortAttrsList = path: list: order: builtins.sort (a: b: (lib.indexOf (lib.attrsets.getAttrFromPath path a) order) < (lib.indexOf (lib.attrsets.getAttrFromPath path b) order)) list;

  mkHost = {
    pkgs,
    inputs,
    system ? "x86_64-linux",
    configuration ? {},
  }:
    with inputs;
    with builtins;
      lib.nixosSystem
      {
        inherit system pkgs lib;
        specialArgs = {inherit inputs;};
        modules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
          stylix.nixosModules.stylix

          ({
            modulesPath,
            config,
            ...
          }: {
            imports = (
              [
                (modulesPath + "/installer/scan/not-detected.nix")
                (modulesPath + "/profiles/qemu-guest.nix")
                ../hosts/${configuration.networking.hostName}/hardware-configuration.nix
                ../modules/nixos
                ../users
              ]
              ++ lib.lists.optional (builtins.pathExists ../hosts/${configuration.networking.hostName}/disks.nix) ../hosts/${configuration.networking.hostName}/disks.nix
            );

            sys.graphics.background = pkgs.fetchurl {
              url = "https://unsplash.com/photos/zRqZOyG78wM/download?ixid=M3wxMjA3fDB8MXxhbGx8Mzl8fHx8fHwyfHwxNjkxODMyNjE2fA&force=true";
              sha256 = "sha256-jwyusMojfJrJNLa3ahoynGsqGSICvwDoQ/CFvE9Co5s=";
            };

            stylix = {
              base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
              image = config.sys.graphics.background;
            };

            nixpkgs.pkgs = pkgs;
            boot.kernelPackages = pkgs.linuxPackages_latest;
            boot.kernelModules = ["i2c-dev"];
            system.stateVersion = stateVersion;
            documentation.man.generateCaches = true;

            environment = {
              systemPackages = with pkgs; [
                killall
                git
                wget
                autorandr
                openssl
                pkg-config
                xclip
                pavucontrol
                (agenix.packages.x86_64-linux.default.override {ageBin = "${pkgs.age}/bin/age";})
              ];
              pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
              shellAliases = {
                open = "${pkgs.xdg-utils}/bin/xdg-open";
              };
            };
            hardware = {
              i2c.enable = true;
            };

            networking = {
              iproute2.enable = true;
              enableIPv6 = true;
              dhcpcd.enable = true;
            };

            services = {
              upower.enable = true;
              xserver = {
                dpi = 125;
              };
              # Enable CUPS to print documents.
              printing.enable = true;
            };
          })

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            # the users are defined in their own modules
          }
          configuration
        ];
      };

  mkHome = {configuration ? {}, ...}: [
    configuration
    {
      imports = [../modules/home-manager];
      home = {
        homeDirectory = "/home/${configuration.home.username}";
        stateVersion = "23.05";
      };
    }
  ];
}
