{...}: {
  programs.starship = {
    enable = true;

    settings = {
      hostname.ssh_only = false;
      shell.disabled = false;
      time.disabled = false;
    };
  };
}
