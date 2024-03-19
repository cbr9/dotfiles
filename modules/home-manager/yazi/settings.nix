{...}: {
  programs.yazi.settings = {
    manager = {
      sort_dir_first = true;
    };
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
}
