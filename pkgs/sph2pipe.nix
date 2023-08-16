{pkgs ? import <nixpkgs> {}, ...}:
with pkgs;
  stdenv.mkDerivation rec {
    name = "sph2pipe";
    version = "1.0";
    src = fetchFromGitHub {
      owner = "robd003";
      repo = "sph2pipe";
      rev = "4488d68d6761f02659bc56e90d3635773255f8a6";
      sha256 = "sha256-O1gAYO+ODas4QR5D5MKpO/4mDXnLnM20f3VbO05jZ6c=";
    };

    buildInputs = [gcc9];
    buildPhase = ''
      gcc -o ${name} *.c -lm
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp -a ${name} $out/bin
    '';
  }
