{pkgs, ...}: {
  config = {
    environment.shells = [pkgs.zsh];
    programs.zsh.enable = false;
    environment.pathsToLink = ["/share/zsh"];
    # environment.systemPackages = [pkgs.zsh-fzf-tab];
  };
}
