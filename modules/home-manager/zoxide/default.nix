{...}: {
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
      "--hook pwd"
    ];
  };
}
