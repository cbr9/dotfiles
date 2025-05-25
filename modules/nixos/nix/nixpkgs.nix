{
  inputs,
  system,
  ...
}: let
  config = {
    allowUnfree = true;
  };
in {
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      (final: prev: {
        organize = inputs.organize.defaultPackage.${system};
        unstable = import inputs.nixpkgs-unstable {inherit system config;};
        agenix = inputs.agenix.packages.x86_64-linux.default.override {ageBin = "${prev.age}/bin/age";};
      })
    ];
  };
}
