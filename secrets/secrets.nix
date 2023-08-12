let
  machines = {
    naboo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUbL64e3CNDr8H9YxCih6DF4AaY5x1wHg0WfJhKp1PS";
    tatooine = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK819Q3ic0PzNb7et7OduCNRFLP65aRNSqBSSgnlbmjv";
    deatcs001ws845 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJIy7G7i6YyI9IY4+1MK7f83b0UR1dApvai+QP9qljsd";
  };

  users = {
    cabero = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOe0bugU6xBMHw8bIMlvEr9TnZ3S185UkTzRJUcmcW6v";
  };

  publicKeys = [
    users.cabero
    machines.naboo
    machines.tatooine
    machines.deatcs001ws845
  ];
in {
  "cabero.age".publicKeys = publicKeys;
}
