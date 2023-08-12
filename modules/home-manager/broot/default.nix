{...}: {
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
    settings = {modal = true;};
  };
}
