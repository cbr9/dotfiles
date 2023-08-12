{pkgs, ...}: {
  config = {
    environment.shells = [pkgs.bash];
  };
}
