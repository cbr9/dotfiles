{
  pkgs,
  nixosConfig,
  ...
}: {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "31vtbbqkijxmfhlidy4clznrf6a4";
        password_cmd = "op item get Spotify --fields password";
        device_name = nixosConfig.networking.hostName;
        backend = "pulseaudio";
        bitrate = 320;
      };
    };
  };

  home.packages = [pkgs.spotify-tui pkgs.spotify];
}
