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
    textEditor = "Helix.desktop";
    fileManager = "lf.desktop";
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
      videoMimeTypes = ["video/*" "audio/*"];
      documentTypes = ["application/pdf"];
      textTypes = ["application/json" "text/*"];
      folderTypes = ["inode/directory"];
    in {
      enable = true;
      defaultApplications = mkMerge [
        (lib.attrsets.genAttrs videoMimeTypes (name: defaultApplications.videoPlayer))
        (lib.attrsets.genAttrs browserMimeTypes (name: defaultApplications.browser))
        (lib.attrsets.genAttrs documentTypes (name: defaultApplications.documentViewer))
        (lib.attrsets.genAttrs textTypes (name: defaultApplications.textEditor))
        (lib.attrsets.genAttrs folderTypes (name: defaultApplications.fileManager))
      ];
      associations = {
        removed = {
          "text/*" = "firefox.desktop";
          "application/json" = "firefox.desktop";
        };
      };
    };
  };
}
