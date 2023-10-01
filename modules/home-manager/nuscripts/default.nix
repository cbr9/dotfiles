{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs; let
  package = stdenv.mkDerivation rec {
    name = "nuscripts";
    version = "056a17ebd6b9c5a57fd552fba18e931b8a50c547";
    src = pkgs.fetchFromGitHub {
      owner = "cbr9";
      repo = "nuscripts";
      rev = version;
      hash = "sha256-dsgFXK2mzbUpUYu8jt+p2j1YswQYnnRyF51Wau/E2Nw=";
    };

    buildPhase = ''
      echo "Linking scripts"
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp -r ${src}/scripts/* $out/bin
      chmod +x -R $out/bin
    '';
  };
in {
  home.packages = [package];
}
