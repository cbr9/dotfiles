{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [ breeze-qt5 ];
  };
}
