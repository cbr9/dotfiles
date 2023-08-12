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
      configuration = {
        stylix.targets.zellij.enable = false;
        stylix.targets.alacritty.enable = false;
        imports = [./packages.nix];
        home.username = "decabera";
      };
    };
}
