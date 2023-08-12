{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    organize = {
      url = "github:cbr9/organizer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst = {
      url = "github:typst/typst";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    system = "x86_64-linux";

    mkLib = nixpkgs:
      nixpkgs.lib.extend
      (final: prev: (import ./lib final));

    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          helix-master = inputs.helix.packages.${system}.default;
          typst-master = inputs.typst.packages.${system}.default;
          organize = inputs.organize.defaultPackage.${system};
          lib = mkLib inputs.nixpkgs;
        })
      ];
      config = {
        allowUnfree = true;
        permittedInsecurePackages = ["electron-21.4.0"];
      };
    };
  in {
    nixosConfigurations = {
      tatooine = import ./hosts/tatooine {inherit inputs pkgs;};
      naboo = import ./hosts/naboo {inherit inputs pkgs;};
      deatcs001ws845 = import ./hosts/deatcs001ws845 {inherit inputs pkgs;};
    };

    homeConfigurations = {
      decabera = import ./users/decabera {inherit inputs pkgs;};
    };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        git-crypt
        git-lfs
        git
      ];
    };
  };
}
