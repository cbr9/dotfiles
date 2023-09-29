{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/nixos-23.05";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix.url = "github:helix-editor/helix";
    organize.url = "github:cbr9/organizer";
    typst.url = "github:typst/typst";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
  };

  outputs = {...} @ inputs: let
    system = "x86_64-linux";

    mkLib = nixpkgs:
      nixpkgs.lib.extend
      (final: prev: (import ./lib final));

    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = (
        [inputs.helix.overlays.default]
        ++ [
          (final: prev: {
            typst-master = inputs.typst.packages.${system}.default;
            papis = prev.papis.overrideAttrs (old: rec {
              pname = "papis-master";
              version = "9aaba9e06e621519fed03cd8f15e1022da97c870";
              src = pkgs.fetchFromGitHub {
                owner = "papis";
                repo = "papis";
                rev = version;
                hash = "sha256-2odPKn91OrBvLCzFNliy0d5aA2AQHYOmtcZz0K2HB+Y=";
              };
              disabledTests =
                old.disabledTests
                ++ [
                  "test_git_cli"
                  "test_add_run"
                  "test_rm_files_run"
                ];
            });
            awesome = inputs.nixpkgs-f2k.packages.${system}.awesome-luajit-git;
            organize = inputs.organize.defaultPackage.${system};
            sph2pipe = import ./pkgs/sph2pipe.nix {pkgs = prev;};
            stable = import inputs.nixpkgs-stable {
              inherit (final) system;
              config = final.config;
            };
            master = import inputs.nixpkgs-master {
              inherit (final) system;
              config = final.config;
            };
            lib = mkLib inputs.nixpkgs;
          })
        ]
      );
      config = {
        allowUnfree = true;
        permittedInsecurePackages = ["electron-21.4.0"];
      };
    };
    lib = pkgs.lib;
  in {
    nixosConfigurations = lib.mkHosts ["naboo" "tatooine" "deatcs001ws845"] inputs pkgs;

    homeConfigurations = {
      decabera = import ./users/decabera {inherit inputs pkgs;};
    };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        git-crypt
        git-lfs
        git
        nix-prefetch-github
      ];
    };
  };
}
