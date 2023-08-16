{
  config,
  nixosConfig,
  lib,
  ...
}: {
  xdg.configFile."tridactyl/tridactylrc" = lib.mkIf (nixosConfig != {}) {
    enable = builtins.elem nixosConfig.nur.repos.rycee.firefox-addons.tridactyl config.programs.firefox.profiles.default.extensions;
    text = ''
      sanitize tridactyllocal tridactylsync

      unbind <C-f>
      bind / fillcmdline find
      bind n findnext 1
      bind N findnext -1

      set smoothscroll true
      bind <Escape> composite mode normal ; hidecmdline ; noh
    '';
  };
}
