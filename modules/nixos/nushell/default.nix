{ pkgs, ... }:
{
  config = {
    environment.shells = [ pkgs.nushell ];
  };
}
