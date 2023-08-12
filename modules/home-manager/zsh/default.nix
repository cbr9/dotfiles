{
  config,
  pkgs,
  ...
}: let
  HOME = config.home.homeDirectory;
in {
  home.sessionVariables = {
    ZSH_COMPDUMP = "${config.home.homeDirectory}/.cache/oh-my-zsh/.zcompdump-$HOST";
  };
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    initExtraFirst = ''
      if [ -e ${HOME}/anaconda3/etc/profile.d/conda.sh ];
      then
        source ${HOME}/anaconda3/etc/profile.d/conda.sh;
      fi
      if [ -e ${HOME}/miniconda3/etc/profile.d/conda.sh ];
      then
        source ${HOME}/miniconda3/etc/profile.d/conda.sh;
      fi
    '';
    initExtra = ''
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -v # vim mode
      bindkey "^E" edit-command-line
      bindkey -s "^W" 'lf^M'
      if [ -e ${HOME}/.config/op/plugins ]; then
        source ${HOME}/.config/op/plugins.sh
      fi
    '';
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "5328eb7c01270417ad6d0ce75682dea00dfa18f2";
          sha256 = "sha256-wUlWy0FqZyluqxnRT7LD57lhEJYZ6Zkm99j99J1ppUE=";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
    };
  };
}
