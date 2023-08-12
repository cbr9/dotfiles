My NixOS configuration. Coolest thing about this configuration is that I don't choose between standalone Home Manager and Home Manager as a NixOS module. I use a hybrid setup where the NixOS config is aware of Home Manager, and viceversa, while keeping separation between the two kinds of packages (except in some cases).

This also means that I can use Home Manager standalone on certain systems (where I don't have sudo access), while using it as NixOS module on NixOS machines!


# How-To

```bash
read -p "Hostname: " HOSTNAME
curl "https://github.com/cbr9/dotfiles/blob/main/hosts/x86_64-linux/$HOSTNAME/disks.nix" -o /tmp/disks.nix
sudo nix run github:nix-community/disko -- --mode disko /tmp/disks.nix
sudo nixos-install --flake "github.com/cbr9/dotfiles#$HOSTNAME"
```
