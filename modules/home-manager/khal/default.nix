{...}: {
  programs.khal = {
    enable = true;
    # locale = {};
  };
  accounts.calendar = {
    basePath = ".calendar";
    accounts.gmail = {
      khal.enable = true;
      primary = true;
      primaryCollection = "gmail";
      name = "Google Calendar";
      local = {};
      remote = {
        # url = "https://calendar.google.com/";
        type = "google_calendar";
        userName = "cabero96@gmail.com";
        passwordCommand = "op item get Google --vault Personal --fields app-password";
      };
    };
  };
}
