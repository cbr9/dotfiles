{ ... }:
{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--walker-skip=.git,.direnv,node_modules"
    ];
  };
}
