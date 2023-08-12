{...}: {
  services.espanso = {
    enable = false;
    configs = {
      default = {
        show_notifications = false;
        inject_delay = 0;
        backend = "Clipboard";
      };
    };
    matches = {
      default = {
        matches =
          [
            {
              trigger = ":ipyfor";
              replace = ''
                for i in $|$:
                  ...
              '';
            }
          ]
          ++ (import ./german.nix);
      };
    };
  };
}
