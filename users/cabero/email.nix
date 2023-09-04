{config, ...}: let
  name = "Andrés Cabero Busto";
in {
  programs = {
    himalaya = {
      enable = true;
      settings = {
        display-name = name;
        downloads-dir = "${config.home.homeDirectory}/Downloads";
        email-listing-page-size = 50;
      };
    };

    thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
    };
  };

  accounts = {
    email = {
      maildirBasePath = "${config.home.homeDirectory}/.maildir";
      accounts = {
        uniStuttgart = rec {
          address = "${userName}@stud.uni-stuttgart.de";
          userName = "st176559";
          realName = name;
          passwordCommand = "op item get 'Universität Stuttgart' --fields password";

          imap = {
            host = "imap.uni-stuttgart.de";
            port = 993;
            tls.enable = true;
          };

          smtp = {
            host = "smtp.uni-stuttgart.de";
            port = 587;
            tls.useStartTls = true;
          };

          thunderbird.enable = true;

          himalaya = {
            enable = true;
            backend = "imap";
            sender = "smtp";
          };
        };
        gmail = {
          primary = true;
          address = "cabero96@gmail.com";
          userName = "cabero96@gmail.com";
          realName = name;
          passwordCommand = "op item get Google --vault Personal --fields app-password";

          imap.host = "imap.gmail.com";
          imap.port = 993;
          smtp.host = "smtp.gmail.com";
          smtp.port = 465;

          thunderbird.enable = true;

          himalaya = {
            enable = true;
            backend = "imap";
            sender = "smtp";

            settings = {
              folder-aliases = {
                inbox = "INBOX";
                sent = "[Gmail]/Sent Mail";
                drafts = "[Gmail]/Drafts";
                trash = "[Gmail]/Trash";
              };
            };
          };
        };
      };
    };
  };
}
