{
  config,
  lib,
  ...
}: {
  programs.firefox.profiles.default.settings = (
    {
      "browser.fullscreen.autohide" = false;
      "browser.aboutConfig.showWarning" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "extensions.formautofill.creditCards.available" = false;
    }
    // (lib.optionalAttrs config.xdg.configFile."tridactyl/tridactylrc".enable {
      "browser.startup.homepage" = "moz-extension://713d476b-6551-420c-b35f-87c66df5b4c6/static/newtab.html";
    })
  );
}
