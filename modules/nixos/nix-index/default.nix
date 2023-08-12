{lib, ...}:
with lib; {
  config = {
    programs.nix-index = {
      enable = true;
    };
    programs.command-not-found.enable = mkForce false;
  };
}
