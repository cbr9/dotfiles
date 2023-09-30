{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.nextcloud-client;
in {
  options = {
    services.nextcloud-client = {
      syncExcludeDeletable = mkOption {
        type = types.listOf types.str;
        default = [
          "*.~*"
          "Icon\r*"
          ".DS_Store"
          ".ds_store"
          "Thumbs.db"
          "photothumb.db"
          ".TemporaryItems"
          ".Trashes"
          ".DocumentRevisions-V100"
          ".Trash-*"
        ];
      };
      syncExcludeNonDeletable = mkOption {
        type = types.listOf types.str;
        default = [
          "*~"
          "~$*"
          ".~lock.*"
          "~*.tmp"
          "*.textClipping"
          "._*"
          "System Volume Information"
          ".*.sw?"
          ".*.*sw?"
          ".fseventd"
          ".apdisk"
          ".Spotlight-V100"
          ".directory"
          "*.part"
          "*.filepart"
          "*.crdownload"
          "*.kate-swp"
          "*.gnucash.tmp-*"
          ".synkron.*"
          ".sync.ffs_db"
          ".symform"
          ".symform-store"
          ".fuse_hidden*"
          "*.unison"
          ".nfs*"
          "My Saved Places."
          "\\#*#"
          ".git*"
          "*.sb-*"
        ];
      };
    };
  };

  config = {
    home.packages = lib.mkIf cfg.enable [cfg.package];
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };

    xdg.configFile = {
      "Nextcloud/sync-exclude.lst" = {
        enable = true;
        text = ''
          ${lib.concatStringsSep "\n" (builtins.map (pat: "]${pat}") cfg.syncExcludeDeletable)}
          ${lib.concatStringsSep "\n" cfg.syncExcludeNonDeletable}
        '';
      };
    };

    home.activation = lib.mkIf cfg.enable {
      linkFolders = lib.hm.dag.entryAfter ["writeBoundary"] ''
        rm -rf ${config.home.homeDirectory}/Documents
        rm -rf ${config.home.homeDirectory}/Pictures
        ln -s ${config.home.homeDirectory}/Nextcloud/Documents  ${config.home.homeDirectory}/Documents
        ln -s ${config.home.homeDirectory}/Nextcloud/Pictures  ${config.home.homeDirectory}/Pictures
      '';
    };
  };
}
