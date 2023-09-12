{pkgs, ...}: {
  config = {
    environment.shells = [pkgs.nushellFull];
  };
}
