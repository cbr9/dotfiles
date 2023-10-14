{
  inputs,
  system,
  ...
}: {
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      (final: prev: {
        typst = inputs.typst.packages.${system}.default;
        awesome = inputs.nixpkgs-f2k.packages.${system}.awesome-luajit-git;
        organize = inputs.organize.defaultPackage.${system};
        stable = inputs.nixpkgs-stable.legacyPackages.${system};
        master = inputs.nixpkgs-master.legacyPackages.${system};
      })
     ] ++ [inputs.helix.overlays.default];

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-21.4.0"
        "mailspring-1.11.0"
      ];
    };
  };
}
