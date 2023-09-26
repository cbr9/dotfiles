{
  nixosConfig,
  lib,
  ...
}: {
  imports = [./tridactyl];

  config = lib.mkIf (nixosConfig != {}) {
    programs.firefox.profiles.default.extensions = with nixosConfig.nur.repos.rycee.firefox-addons; [
      ghostery
      clearurls
      tridactyl
      decentraleyes
      privacy-redirect
      plasma-integration
      youtube-shorts-block
      youtube-recommended-videos # unhook
      i-dont-care-about-cookies
      (
        buildFirefoxXpiAddon rec {
          pname = "simple-translate";
          version = "2.8.1";
          url = "https://addons.mozilla.org/firefox/downloads/file/4072586/simple_translate-${version}.xpi";
          sha256 = "sha256-I/GVPViNXZlDq0OEVAe4SlG7zBgkuMAQ7VbKoRlxGic=";
          addonId = "simple-translate@sienori";
          meta = {};
        }
      )
      (
        buildFirefoxXpiAddon rec {
          pname = "toucan";
          version = "2.15.3";
          url = "https://addons.mozilla.org/firefox/downloads/file/3964416/toucan_language_learning-${version}.xpi";
          sha256 = "sha256-fiL9jsCpQhlqTh/ouxsjm+wjljTm+ygTdnNTxYgDtns=";
          addonId = "{fe50e88d-a084-4ff2-9d58-eeac466f937e}";
          meta = {};
        }
      )
      (
        buildFirefoxXpiAddon rec {
          pname = "popup-blocker";
          version = "0.6.8";
          url = "https://addons.mozilla.org/firefox/downloads/file/3821195/popup_blocker-${version}.xpi";
          sha256 = "sha256-qXJlA/9UzXEF3sHJdTfG0N3spYXhZt5MgjOXETdT5sw=";
          addonId = "{de22fd49-c9ab-4359-b722-b3febdc3a0b0}";
          meta = {};
        }
      )
      (
        buildFirefoxXpiAddon {
          pname = "1password-beta";
          version = "latest";
          url = "https://c.1password.com/dist/1P/b5x/firefox/beta/latest.xpi";
          sha256 = "sha256-5HMolg5sbHu3+8l9kVD0bzaWBp6QLy528I2DorTKUoY=";
          addonId = "{25fc87fa-4d31-4fee-b5c1-c32a7844c063}";
          meta = {};
        }
      )
      (
        buildFirefoxXpiAddon rec {
          pname = "Zotero";
          version = "5.0.111";
          url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=${version}";
          sha256 = "sha256-2bXqbIVRm1jIVtjHSZJpa6Th3CdxXqMHezOg1BguMdo=";
          addonId = "zotero@chnm.gmu.edu";
          meta = {};
        }
      )
    ];
  };
}
