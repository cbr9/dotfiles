{
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    organize.url = "github:cbr9/organizer";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
  };

  outputs = {...} @ inputs: let
    system = "x86_64-linux";
    mkLib = nixpkgs:
      nixpkgs.lib.extend
      (final: prev: (import ./lib final));
    lib = mkLib inputs.nixpkgs;
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = lib.mkHosts ["naboo"] system inputs;

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
