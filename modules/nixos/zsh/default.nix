{pkgs, ...}: {
  config = {
    environment.shells = [pkgs.zsh];
    programs.zsh.enable = true;
    environment.pathsToLink = ["/share/zsh"];
    # environment.systemPackages = [pkgs.zsh-fzf-tab];
  };
}
