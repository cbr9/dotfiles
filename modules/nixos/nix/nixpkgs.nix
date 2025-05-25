{
  inputs,
  system,
  ...
}:
let
  config = {
    allowUnfree = true;
  };
in
{
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      (final: prev: {
        organize = inputs.organize.defaultPackage.${system};
        unstable = import inputs.nixpkgs-unstable { inherit system config; };
        agenix = inputs.agenix.packages.x86_64-linux.default.override { ageBin = "${prev.age}/bin/age"; };
        google-chrome = (
          prev.google-chrome.override {
            commandLineArgs = [
              "--force-device-scale-factor=1.25"
              "--ozone-platform-hint=wayland"
            ];
          }
        );

        # _1password-gui = (
        #   final._1password-gui.override {
        #     commandLineArgs = [
        #       "--force-device-scale-factor=1.25"
        #       # "--enable-features=UseOzonePlatform"
        #       # "--ozone-platform-hint=wayland"
        #     ];
        #   }
        # );

        # spotify = (
        #   prev.spotify.override {
        #     commandLineArgs = [
        #       "--force-device-scale-factor=1.25"
        #       "--enable-features=UseOzonePlatform"
        #       "--ozone-platform-hint=wayland"
        #     ];
        #   }
        # );
      })
    ];
  };
}
