{
  inputs,
  system,
  ...
}: let
  config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-21.4.0"
      "mailspring-1.11.0"
    ];
  };
in {
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      (import ../../../pkgs) # custom packages
      (final: prev: {
        typst = inputs.typst.packages.${system}.default;
        awesome = inputs.nixpkgs-f2k.packages.${system}.awesome-luajit-git;
        organize = inputs.organize.defaultPackage.${system};
        stable = import inputs.nixpkgs-stable {inherit system config;};
        master = import inputs.nixpkgs-master {inherit system config;};
      })
      inputs.helix.overlays.default
    ];
  };
}
