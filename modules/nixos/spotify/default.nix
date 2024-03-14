{
  pkgs,
  lib,
  config,
  ...
}: {
  networking.firewall = {
    allowedUDPPorts = [5353];
    allowedTCPPorts = [57621];
  };

  age.secrets.spotify.file = ../../../secrets/spotify.age;

  home-manager.users.cabero = {
    services.spotifyd = {
      enable = true;
      package = pkgs.stable.spotifyd;
      settings = {
        global = {
          username = "31vtbbqkijxmfhlidy4clznrf6a4";
          password_cmd = "sudo cat /run/agenix/spotify";
          device_name = "${config.networking.hostName}-daemon";
          backend = "pulseaudio";
          bitrate = 320;
        };
      };
    };

    home.packages = let
      spotify = pkgs.writeScriptBin "spotify" ''
        ${pkgs.spotify}/bin/spotify --disable-gpu # fix font glitch
      '';
    in [pkgs.spotify (lib.hiPrio spotify)];
  };
}
