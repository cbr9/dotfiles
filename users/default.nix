{lib, ...}:
with lib; {
  imports = [
    ./cabero
  ];

  options.sys.users = mkOption {
    type = types.nonEmptyListOf types.nonEmptyStr;
    default = [];
  };

  config = {
    users.mutableUsers = false;
    users.users.root = {
      hashedPassword = "!";
    };
  };
}
