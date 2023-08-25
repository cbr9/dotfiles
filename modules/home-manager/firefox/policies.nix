{config, ...}: {
  DefaultDownloadDirectory = config.xdg.userDirs.download;
  DownloadDirectory = config.xdg.userDirs.download;
  PromptForDownloadLocation = false;
  EnableTrackingProtection = true;
  DisableSetDesktopBackground = true;
  DisableMasterPasswordCreation = true;
  DisableFormHistory = true;
  DisableAppUpdate = true;
  DisableFirefoxAccounts = true;
  OfferToSaveLogins = false;
  DisplayBookmarksToolbar = "never";
  ShowHomeButton = true;
  CaptivePortal = false;
  DisableFirefoxStudies = true;
  DisablePocket = true;
  DisableTelemetry = true;
  FirefoxHome = {
    Pocket = false;
    Snippets = false;
    TopSites = false;
    SponsoredTopSites = false;
    SponsoredPocket = false;
  };
  UserMessaging = {
    ExtensionRecommendations = false;
    SkipOnboarding = true;
  };
}
