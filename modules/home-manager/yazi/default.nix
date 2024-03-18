{...}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;

    settings = {
      opener = {
        text = [
          {
            run = "hx $@";
            block = true;
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = "text";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            name = "*.json";
            use = "text";
          }
        ];
      };
    };
  };
}
