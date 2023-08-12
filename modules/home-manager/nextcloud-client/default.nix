{
  config,
  lib,
  ...
}: {
  services.nextcloud-client = {
    enable = config.home.username != "decabera";
    startInBackground = true;
  };
  home.activation = lib.mkIf config.services.nextcloud-client.enable {
    linkFolders = lib.hm.dag.entryAfter ["writeBoundary"] ''
      rm -rf ${config.home.homeDirectory}/Documents
      rm -rf ${config.home.homeDirectory}/Pictures
      ln -s ${config.home.homeDirectory}/Nextcloud/Documents  ${config.home.homeDirectory}/Documents
      ln -s ${config.home.homeDirectory}/Nextcloud/Pictures  ${config.home.homeDirectory}/Pictures
    '';
  };
}
