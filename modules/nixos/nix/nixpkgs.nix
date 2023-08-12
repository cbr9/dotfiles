{...}: {
  config = {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = ["electron-21.4.0"];
    };
  };
}
