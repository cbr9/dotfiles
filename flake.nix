{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/nixos-23.05";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
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
    organize.url = "git+ssh://git@github.com/cbr9/organizer";
    agenix.url = "github:ryantm/agenix";
    stylix.url = "github:danth/stylix";
    yazi.url = "github:sxyazi/yazi";
    typst.url = "github:typst/typst";
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
