{
  inputs,
  system,
  ...
}: let
  config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
      "zotero-6.0.27"
      "electron-27.3.11"
    ];
  };
in {
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      inputs.helix.overlays.default
      inputs.yazi.overlays.default
      (final: prev: {
        awesome = inputs.nixpkgs-f2k.packages.${system}.awesome-luajit-git;
        organize = inputs.organize.defaultPackage.${system};
        stable = import inputs.nixpkgs-stable {inherit system config;};
        master = import inputs.nixpkgs-master {inherit system config;};
        agenix = inputs.agenix.packages.x86_64-linux.default.override {ageBin = "${prev.age}/bin/age";};
      })
    ];
  };
}
