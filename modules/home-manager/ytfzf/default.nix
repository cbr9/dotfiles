{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.ytfzf;
in {
  options = {
    programs.ytfzf = with lib; {
      enable = mkEnableOption "Enable ytfzf";
      invidiousInstance = mkOption {
        type = types.str;
        default = null;
      };
      subscriptionHashes = mkOption {
        type = types.listOf types.str;
        default = [];
      };
    };
  };

  config = {
    programs.ytfzf = {
      enable = true;
      invidiousInstance = "https://yt.artemislena.eu";
      subscriptionHashes = [
        "UCoOae5nYA7VqaXzerajD0lg"
        "UCIaH-gZIVC432YRjNVvnyCA"
        "UCkUaT0T03TJvafYkfATM2Ag"
        "UCL_f53ZEJxp8TtlOkHwMV9Q"
        "UC-qsP49Ai2GymJgyKX38l1w"
      ];
    };
    home.packages = [pkgs.ytfzf pkgs.ffmpeg_6-full];
    xdg.configFile."ytfzf/conf.sh" = {
      enable = cfg.enable;
      text =
        # bash
        ''
          ytdl_pref="bv*[height<=1200]+ba/b[width<2000] / wv*+ba/w"
          invidious_instance=${cfg.invidiousInstance}
          yt_video_link_domain=${cfg.invidiousInstance}
        '';
    };
    xdg.configFile."ytfzf/subscriptions" = {
      enable = cfg.enable && cfg.subscriptionHashes != [];
      text = let
        subscriptions = builtins.map (hash: "${cfg.invidiousInstance}/channel/${hash}") cfg.subscriptionHashes;
      in
        lib.concatStringsSep "\n" subscriptions;
    };
  };
}
