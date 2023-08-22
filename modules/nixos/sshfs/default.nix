{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  imports = [];
  options.services.sshfs = with lib; {
    profiles = mkOption {
      default = [];
      type = types.listOf (
        types.submodule
        {
          options = {
            enable = mkEnableOption "Enable this profile";
            user = mkOption {
              type = types.nonEmptyStr;
              description = "Your username on the remote server";
            };
            host = mkOption {
              type = types.nonEmptyStr;
              description = "The server from which to mount directories";
            };
            dirs = mkOption {
              type = types.listOf types.nonEmptyStr;
              description = "Folders that will be mounted locally using sshfs";
            };
            key = mkOption {
              type = types.nonEmptyStr;
              description = "SSH Key to use sshfs with";
            };
            mountpoint = mkOption {
              type = types.nonEmptyStr;
              default = "/mnt";
            };
          };
        }
      );
    };
  };

  config = let
    concatLists = lib.lists.foldl (a: b: a ++ b) [];
    mountProfile = profile: let
      uid = builtins.toString config.users.users.cabero.uid;
    in
      if (profile.enable)
      then
        pkgs.lib.lists.forEach profile.dirs (dir: {
          where = "${profile.mountpoint}/${dir}";
          type = "fuse.sshfs";
          what = "${profile.user}@${profile.host}:${dir}";

          mountConfig = {
            Options = pkgs.lib.strings.concatStringsSep "," [
              "noauto"
              "noatime"
              "_netdev"
              "reconnect"
              "allow_other"
              "uid=${uid}"
              "x-systemd.automount"
              "idmap=user"
              "default_permissions"
              "IdentityAgent=/home/cabero/.1password/agent.sock"
            ];
          };
        })
      else [];

    autoMountProfile = profile:
      if profile.enable
      then
        lib.lists.forEach profile.dirs (dir: {
          wantedBy = ["multi-user.target"];
          automountConfig = {
            TimeoutIdleSec = "60";
          };
          where = "${profile.mountpoint}/${dir}";
        })
      else [];
  in
    lib.mkIf (config.services.sshfs.profiles != []) {
      environment.systemPackages = with pkgs; [sshfs];
      programs.fuse.userAllowOther = true;

      services.rpcbind.enable = true;
      systemd.mounts = concatLists (lib.forEach config.services.sshfs.profiles (prof: mountProfile prof));
      systemd.automounts = concatLists (lib.lists.forEach config.services.sshfs.profiles (prof: autoMountProfile prof));
    };
}
