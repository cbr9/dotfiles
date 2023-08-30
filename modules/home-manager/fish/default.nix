{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;

    shellInit = let
      HOME = "${config.home.homeDirectory}";
    in ''
      set -g fish_greeting ""
      set -gx fish_escape_delay_ms 1000

      if test -f ${HOME}/.nix-profile/etc/profile.d/nix.fish
        source ${HOME}/.nix-profile/etc/profile.d/nix.fish
      end

      if test -f ${HOME}/.config/op/plugins
        source ${HOME}/.config/op/plugins.sh
      end
    '';

    plugins = with pkgs; [
      {
        #  automatically receive notifications when long processes finish.
        name = "done";
        src = fishPlugins.done.src;
      }
      {
        # text expansions
        name = "puffer";
        src = fishPlugins.puffer.src;
      }
      {
        # paired symbols
        name = "pisces";
        src = fishPlugins.pisces.src;
      }
    ];
  };

  xdg.configFile = lib.mkIf config.programs.fish.enable {
    "fish/completions/sbatch.fish".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/gvtulder/fish-slurm-completions/a5b7360e6b1a3fd242ecde9ad09971fcdf672ba1/completions/sbatch.fish";
      sha256 = "145jxqyw52bx5wvicjy3yy0amvwcwb4psq38b9xmfc7gafpw1sm2";
    };
    "fish/completions/scancel.fish".source = pkgs.fetchurl {
      url = "https://github.com/gvtulder/fish-slurm-completions/raw/a5b7360e6b1a3fd242ecde9ad09971fcdf672ba1/completions/scancel.fish";
      sha256 = "0604gv4daddsk24p4slgi9kcmvhyib3l2szq90b6lhg8sc2745c1";
    };
    "fish/completions/scontrol.fish".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/gvtulder/fish-slurm-completions/a5b7360e6b1a3fd242ecde9ad09971fcdf672ba1/completions/scontrol.fish";
      sha256 = "0p72m45p16sn5ral6zgzs3ask1b6cbsgxync43qvqc08w02g35z1";
    };
    "fish/completions/squeue.fish".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/gvtulder/fish-slurm-completions/a5b7360e6b1a3fd242ecde9ad09971fcdf672ba1/completions/squeue.fish";
      sha256 = "1wd0zjj4mdc512rfyp53ddmpyxkd10ww6dyq2zhrgbvmhlp31bns";
    };
    "fish/functions/__fish_complete_slurm_comma_separated.fish".source = pkgs.fetchurl {
      url = "https://github.com/gvtulder/fish-slurm-completions/raw/a5b7360e6b1a3fd242ecde9ad09971fcdf672ba1/functions/__fish_complete_slurm_comma_separated.fish";
      sha256 = "1fk52j1ys30b7qif46ccnwxpg40abjsyvq1fcqslwkhym0b0mwi8";
    };
    "fish/functions/__fish_complete_slurm_common.fish".source = pkgs.fetchurl {
      url = "https://github.com/gvtulder/fish-slurm-completions/raw/a5b7360e6b1a3fd242ecde9ad09971fcdf672ba1/functions/__fish_complete_slurm_common.fish";
      sha256 = "0n409cxddz103c0krnv1vx9j7r0hg9szg139llb6iqplsq5275nz";
    };
  };
}
