{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      filen = prev.callPackage ./filen.nix {};
      sph2pipe = prev.callPackage ./sph2pipe.nix {};
    })
  ];
}
