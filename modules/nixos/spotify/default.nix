{
  pkgs,
  config,
  ...
}: {
  age.secrets = {
    spotify.file = ../../../secrets/spotify.age;
  };

  home-manager.users.cabero = {
    services.spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "31vtbbqkijxmfhlidy4clznrf6a4";
          password = config.age.secrets.spotify.path;
        };
      };
    };

    home.packages = [pkgs.spotify-tui pkgs.spotify];
  };
}
