{...}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      embed-subs = true;
      embed-chapters = true;
      progress = true;
      console-title = true;
      sub-langs = "all";
      downloader = "aria2c";
    };
  };
}
