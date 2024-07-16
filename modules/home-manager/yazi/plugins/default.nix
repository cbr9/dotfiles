{pkgs, ...}: let
  plugins-repo = pkgs.fetchFromGitHub {
		owner = "yazi-rs";
		repo = "plugins";
		rev = "0dc9dcd5794ca7910043174ec2f2fe3561016983";
		hash = "";
  };
in {
  programs.yazi.plugins = {
      smart-paste = ./smart-paste.yazi;
      smart-filter = "${plugins-repo}/smart-filter.yazi";
    
  }
}
