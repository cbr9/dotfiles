let
  machines = {
    naboo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxudPq1dhYSEGEZafEwAUm/+evxOdUE/OtwFdsnolNK root@naboo";
  };

  users = {
    cabero = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe0bugU6xBMHw8bIMlvEr9TnZ3S185UkTzRJUcmcW6v";
  };

  publicKeys = [
    users.cabero
    machines.naboo
  ];
in {
  "cabero-15582531.age".publicKeys = publicKeys;
  "cabero.age".publicKeys = publicKeys;
  "cabero-15582547.age".publicKeys = publicKeys;
  "spotify.age".publicKeys = publicKeys;
}
