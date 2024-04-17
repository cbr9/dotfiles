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
      plasma-integration
      youtube-shorts-block
      youtube-recommended-videos # unhook
      i-dont-care-about-cookies
      (
        buildFirefoxXpiAddon rec {
          pname = "simple_translate";
          version = "2.8.1";
          url = "https://addons.mozilla.org/firefox/downloads/file/4072586/${pname}-${version}.xpi";
          sha256 = "sha256-I/GVPViNXZlDq0OEVAe4SlG7zBgkuMAQ7VbKoRlxGic=";
          addonId = "simple-translate@sienori";
          meta = {};
        }
      )
      (
        buildFirefoxXpiAddon rec {
          pname = "popup_blocker";
          version = "0.6.9.1";
          url = "https://addons.mozilla.org/firefox/downloads/file/4192604/${pname}-${version}.xpi";
          sha256 = "sha256-lff3uH/eMIKdGF6+tzW2purFvzo4nkc8v6kTjCV9LBY=";
          addonId = "{de22fd49-c9ab-4359-b722-b3febdc3a0b0}";
          meta = {};
        }
      )
      (
        buildFirefoxXpiAddon {
          pname = "1password-beta";
          version = "latest";
          url = "https://c.1password.com/dist/1P/b5x/firefox/beta/latest.xpi";
          sha256 = "sha256-R97o7lhF3U0HJ7joMjYpK9p+zt+1L1G5J4X7GEPENzg=";
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
