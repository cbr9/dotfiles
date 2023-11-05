{
  inputs,
  system,
  ...
}: let
  config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-21.4.0"
      "electron-19.1.9"
      "electron-24.8.6"
      "mailspring-1.11.0"
      "zotero-6.0.27"
    ];
  };
in {
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      (import ../../../pkgs) # custom packages
      (final: prev: {
        typst = inputs.typst.packages.${system}.default;
        organize = inputs.organize.defaultPackage.${system};
        stable = import inputs.nixpkgs-stable {inherit system config;};
        master = import inputs.nixpkgs-master {inherit system config;};
        agenix = inputs.agenix.packages.x86_64-linux.default.override {ageBin = "${prev.age}/bin/age";};
      })
      inputs.helix.overlays.default
    ];
  };
}
