{...}: {
  programs.yazi.settings = {
    opener = {
      edit = [
        { run = "${pkgs.helix}/bin/hx $@"; block = true; }
      ];
      video = [
        { run = "${pkgs.vlc}/bin/vlc $@"; orphan = true;}
      ];
      ouch_no = [
        { run = "${pkgs.ouch}/bin/ouch d --no $@"; orphan = true; desc = "Decompress without overwriting";}
      ];
      ouch_yes = [
        { run = "${pkgs.ouch}/bin/ouch d --yes $@"; orphan = true; desc = "Decompress without overwriting";}
      ];
    };

    open = {
      rules = [
        { mime = "text/*"; use = "open" }
        { mime = "*/xml"; use = "open" }
        { mime = "text/x-toml"; use = "open" }
        { mime = "image/*"; use = "image" }
        { mime = "video/*"; use = "media"}
        { mime = "audio/*"; use = "media"}

        { name = "*.zip"; use = ["ouch_no" "ouch_yes"]}
        { name = "*.srt"; use = "open"}
        { name = "*.isi"; use = "open"}
        { mime = "application/json"; use = "open" }
        { name = "*.toml"; use = "open" }

        # Multiple openers for a single rule
        { name = "*.html"; use = [ "browser" "open" ] }
        { mime = "inode/x-empty"; use = "open"}
      ];
    };
  };
}
