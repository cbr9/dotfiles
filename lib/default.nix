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

  boolToString = bool:
    if bool == true
    then "true"
    else "false";

  mkHosts = hosts: system: inputs:
    lib.genAttrs hosts (host:
      lib.mkHost {
        inherit inputs system;
        hostName = host;
      });

  mkHost = {
    inputs,
    hostName,
    system ? "x86_64-linux",
  }:
    with inputs;
    with builtins;
      lib.nixosSystem
      {
        inherit system lib;
        specialArgs = {inherit inputs system;};

        modules = [
          disko.nixosModules.disko
          agenix.nixosModules.default
          stylix.nixosModules.stylix
          nur.nixosModules.nur

          ({
            modulesPath,
            config,
            pkgs,
            ...
          }: {
            imports = [
              (modulesPath + "/installer/scan/not-detected.nix")
              (modulesPath + "/profiles/qemu-guest.nix")
              ../hosts/${hostName}/hardware-configuration.nix
              ../hosts/${hostName}/configuration.nix
              ../hosts/${hostName}/disks.nix
              ../users
              ../pkgs
              ../modules/nixos
            ];

            config = {
              stylix = {
                base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
                image = pkgs.fetchurl {
                  url = "https://unsplash.com/photos/fYTVHcpak2g/download?ixid=M3wxMjA3fDF8MXxhbGx8OTF8fHx8fHwyfHwxNjk0NjMxNjg4fA";
                  sha256 = "0ifg4nxr37v7gwi2yrnj0r6k87ksr87s19fs782zvgxi6gx5p7hs";
                };
              };

              boot.kernelPackages = pkgs.linuxPackages_latest;
              boot.kernelModules = ["i2c-dev"];
              system.stateVersion = stateVersion;
              documentation.man.generateCaches = true;
              powerManagement.enable = true;

              environment = {
                systemPackages = with pkgs; [
                  killall
                  git
                  wget
                  autorandr
                  openssl
                  libnotify
                  pkg-config
                  xclip
                  pavucontrol
                  (agenix.packages.x86_64-linux.default.override {ageBin = "${pkgs.age}/bin/age";})
                ];

                pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
              };
              hardware = {
                i2c.enable = true;
              };

              networking = {
                inherit hostName;
                iproute2.enable = true;
                enableIPv6 = true;
                dhcpcd.enable = true;
              };

              services = {
                upower.enable = true;
                # Enable CUPS to print documents.
                printing.enable = true;
              };
            };
          })

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {inherit inputs;};
          }
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
