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

  home-manager.users.cabero = {
    services.spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "31vtbbqkijxmfhlidy4clznrf6a4";
          password_cmd = "op item get Spotify --fields password";
          device_name = "${config.networking.hostName}-daemon";
          backend = "pulseaudio";
          bitrate = 320;
        };
      };
    };

    # xdg.desktopEntries.Spotify = {
    #   name = "Spotify";
    #   genericName = "Music Player";
    #   icon = "spotify-client";
    #   type = "Application";
    #   exec = "${pkgs.spotify}/bin/spotify --uri=%U --disable-gpu";
    #   terminal = false;
    #   categories = ["Audio" "Music" "Player" "AudioVideo"];
    #   mimeType = ["x-scheme-handler/spotify"];
    # };

    home.packages = let
      spotify = pkgs.writeScriptBin "spotify" ''
        ${pkgs.spotify}/bin/spotify --disable-gpu
      '';
    in [pkgs.spotify-tui pkgs.spotify (lib.hiPrio spotify)];
  };
}
