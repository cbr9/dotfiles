{
  config,
  pkgs,
  ...
}: let
  path = "${config.home.homeDirectory}/.repos/dotfiles/modules/programs/nap/snippets";
in {
  home.packages = with pkgs; [nap];
  home.file.".local/share/nap" = {
    source = config.lib.file.mkOutOfStoreSymlink path;
  };
}
