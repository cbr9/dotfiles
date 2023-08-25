{
  inputs,
  pkgs,
  ...
}:
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = {
    inherit inputs;
    nixosConfig = {};
  };
  modules =
    [inputs.stylix.homeManagerModules.stylix]
    ++ pkgs.lib.mkHome {
      inherit inputs;
      configuration = rec {
        imports = [./packages.nix];
        home.username = "decabera";

        home.sessionVariables = {
          XDG_RUNTIME_DIR = "/home/${home.username}/.tmp";
        };

        stylix = {
          autoEnable = false;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
          image = pkgs.fetchurl {
            url = "https://unsplash.com/photos/zRqZOyG78wM/download?ixid=M3wxMjA3fDB8MXxhbGx8Mzl8fHx8fHwyfHwxNjkxODMyNjE2fA&force=true";
            sha256 = "sha256-jwyusMojfJrJNLa3ahoynGsqGSICvwDoQ/CFvE9Co5s=";
          };
          targets = {
            fish.enable = true;
            fzf.enable = true;
          };
        };
      };
    };
}
