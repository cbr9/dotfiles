{pkgs, ...}: {
  programs.yazi.settings = {
    opener = {
      edit = [
        {
          run = "${pkgs.helix}/bin/hx \"$@\"";
          block = true;
        }
      ];
      open = [
        {
          run = "xdg-open \"$@\"";
          orphan = true;
        }
      ];
      video = [
        {
          run = "${pkgs.vlc}/bin/vlc \"$@\"";
          orphan = true;
        }
      ];
      ouch_no = [
        {
          run = "${pkgs.ouch}/bin/ouch d --no \"$@\"";
          orphan = true;
          desc = "Decompress without overwriting";
        }
      ];
      ouch_yes = [
        {
          run = "${pkgs.ouch}/bin/ouch d --yes \"$@\"";
          orphan = true;
          desc = "Decompress without overwriting";
        }
      ];
    };

    open = {
      rules = [
        {
          mime = "text/*";
          use = "edit";
        }
        {
          mime = "*/xml";
          use = "edit";
        }
        {
          mime = "text/x-toml";
          use = "edit";
        }
        {
          mime = "application/pdf";
          use = "open";
        }
        {
          mime = "image/*";
          use = "image";
        }
        {
          mime = "video/*";
          use = "media";
        }
        {
          mime = "audio/*";
          use = "media";
        }
        {
          name = "*.zip";
          use = ["ouch_no" "ouch_yes"];
        }
        {
          name = "*.srt";
          use = "edit";
        }
        {
          name = "*.isi";
          use = "edit";
        }
        {
          mime = "application/json";
          use = "edit";
        }
        {
          name = "*.toml";
          use = "edit";
        }

        # Multiple editers for a single rule
        {
          name = "*.html";
          use = ["browser" "edit"];
        }
        {
          mime = "inode/x-empty";
          use = "edit";
        }
      ];
    };
  };
}
