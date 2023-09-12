{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    configFile.text =
      # nu
      ''
        $env.config = {
          show_banner: false,
        }

        ${
          lib.optionalString (config.home.username == "decabera")
          # nu
          ''
            def nusqueue [] {
              let table = squeue --format "%i\t%u\t%M\t%B\t%j\t%P\t%g\t%T\t%Q" | from tsv
              let time = $table |  get TIME |  parse -r '(?:(?P<DAYS>\d+)-)?(?:(?P<HOURS>\d?\d):)?(?P<MINUTES>\d?\d):(?P<SECONDS>\d\d)' |  str replace -r "^$" "0" HOURS DAYS
              let time = $time | format '{DAYS}day {HOURS}hr {MINUTES}min {SECONDS}sec' | into duration
              let time = [[TIME]; [$time]] | flatten
              let table = $table | reject TIME | merge $time
              return $table
            }
          ''
        }
      '';
  };
}
