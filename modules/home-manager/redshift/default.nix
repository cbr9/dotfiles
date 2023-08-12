{...}: {
  services.redshift = {
    enable = true;
    settings.redshift = {
      brightness-day = "1";
      brightness-night = "1";
    };
    temperature = {
      day = 5500;
      night = 3000;
    };
    dawnTime = "6:00-7:45";
    duskTime = "20:00-21:00";
    latitude = 48.7758;
    longitude = 9.1829;
  };
  home.file.".config/systemd/user/default.target.wants/redshift.service".text = "";
}
