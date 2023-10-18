{...}: {
  programs = {
    himalaya = {
      enable = true;
    };
  };

  programs.fish.shellAbbrs = {
    gmail = "himalaya --account gmail";
    fastmail = "himalaya --account fastmail";
  };

  accounts.email.accounts = {
    gmail = rec {
      realName = "Andrés Cabero Busto";
      userName = address;
      address = "cabero96@gmail.com";
      flavor = "gmail.com";
      passwordCommand = "op item get mabeprajjbkhfxypc3bggs4w5m --fields app-password";

      folders = {
        inbox = "INBOX";
        sent = "[Gmail]/Sent Mail";
        drafts = "[Gmail]/Drafts";
        trash = "[Gmail]/Trash";
      };

      himalaya = {
        enable = true;
      };
    };

    fastmail = rec {
      primary = true;
      realName = "Andrés Cabero Busto";
      userName = address;
      address = "cabero96@fastmail.com";
      aliases = ["andres.caberobusto@fastmail.com"];
      flavor = "fastmail.com";
      passwordCommand = "op item get fastmail --fields app-password";

      himalaya = {
        enable = true;
      };
    };
  };
}
