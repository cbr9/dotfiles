{nixosConfig, ...}: {
  programs.firefox.profiles.default.extensions = with nixosConfig.nur.repos.rycee.firefox-addons; [
    ghostery
    clearurls
    tridactyl
    decentraleyes
    cookie-autodelete
    darkreader
    youtube-shorts-block
    youtube-recommended-videos # unhook
    # vimium
    ublock-origin
    duckduckgo-privacy-essentials
    sponsorblock
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
        sha256 = "sha256-PYD7c6J6dlR6K47uMDz/oM1M8msHEBxIQmYdadao0Gk=";
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
}
