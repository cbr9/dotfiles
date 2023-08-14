{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  defaultApplications = {
    browser = "firefox.desktop";
    videoPlayer = "vlc.desktop";
    documentViewer = "org.gnome.Evince.desktop";
  };
in {
  home.packages = with pkgs; [vlc evince];
  xdg = {
    enable = true;
    userDirs = {
      extraConfig = {
        XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";
      };
      createDirectories = true;
    };
    mimeApps = let
      browserMimeTypes = (
        ["text/html"]
        ++ lib.lists.forEach ["http" "https" "about" "unknown"]
        (x: "x-scheme-handler/" + x)
      );
      videoMimeTypes = ["video/x-matroska" "audio/x-matroska" "video/mp4"];
      documentTypes = ["application/pdf"];
    in {
      enable = true;
      defaultApplications = mkMerge [
        (lib.attrsets.genAttrs videoMimeTypes (name: defaultApplications.videoPlayer))
        (lib.attrsets.genAttrs browserMimeTypes (name: defaultApplications.browser))
        (lib.attrsets.genAttrs documentTypes (name: defaultApplications.documentViewer))
      ];
    };
  };
}
